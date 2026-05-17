import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/db/access/search.dart';
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:bingetube/pages/search/widgets/search_formatters.dart';
import 'package:bingetube/pages/search/widgets/search_state_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchVideoWidget extends ConsumerStatefulWidget {
  static final Logger _logger = LogManager.getLogger('SearchVideoWidget');

  final String? query;
  final bool isActive;
  final void Function(ScrollController) scrollListener;

  const SearchVideoWidget(
    this.query, {
    required this.isActive,
    required this.scrollListener,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchVideoState();
}

class _SearchVideoState extends ConsumerState<SearchVideoWidget>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  bool _isValidQuery = false;
  bool _isLoaded = false;
  VideoSearchModel? _model;

  _SearchVideoState();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_isValidQuery) {
      return const SearchStateView(
        icon: Icons.smart_display_outlined,
        title: 'Search videos',
        message: 'Find videos and open the result set as a playable queue.',
      );
    }

    if (!_isLoaded) {
      return const SearchStateView(
        icon: Icons.smart_display_outlined,
        title: 'Searching videos',
        message: 'Looking through YouTube for matching videos.',
        isLoading: true,
      );
    }

    if (_model == null) {
      return const SearchStateView(
        icon: Icons.cloud_off_outlined,
        title: 'Search failed',
        message: 'Check your API key or connection, then try again.',
      );
    }

    final videos = _model!.videos;
    if (videos.isEmpty) {
      return const SearchStateView(
        icon: Icons.search_off_outlined,
        title: 'No videos found',
        message: 'Try another title, topic, creator, or exact phrase.',
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: videos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _buildVideoCard(context, videos[index]),
    );
  }

  @override
  void didUpdateWidget(covariant SearchVideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final queryChanged = widget.query != oldWidget.query;
    final becameActive = widget.isActive && !oldWidget.isActive;

    if (queryChanged) {
      _resetSearch();
    }

    if (widget.isActive && (queryChanged || becameActive)) {
      _processRequest(widget.query);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() => widget.scrollListener(_scrollController));
    if (widget.isActive) {
      _processRequest(widget.query);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildVideoCard(BuildContext context, VideoModel video) {
    final theme = Theme.of(context);
    final thumbnailUrl = video.thumbnails.mediumUrl;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: () => _openVideo(video, thumbnailUrl),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 420;
            final thumbnail = _buildThumbnail(context, video, thumbnailUrl, isNarrow);
            final details = _buildVideoDetails(context, video);

            if (isNarrow) {
              return Column(
                crossAxisAlignment: .stretch,
                children: [
                  thumbnail,
                  Padding(padding: const EdgeInsets.all(12), child: details),
                ],
              );
            }

            return Row(
              crossAxisAlignment: .center,
              children: [
                thumbnail,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
                    child: details,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildThumbnail(
    BuildContext context,
    VideoModel video,
    String thumbnailUrl,
    bool isNarrow,
  ) {
    final thumbnail = AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: video.video.id,
            child: Image.network(
              thumbnailUrl,
              fit: .cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildThumbnailFallback(context);
              },
            ),
          ),
          if (video.duration > 0)
            Positioned(
              right: 6,
              bottom: 6,
              child: _buildDurationBadge(context, video.formatDuration()),
            ),
        ],
      ),
    );

    if (isNarrow) {
      return thumbnail;
    }
    return SizedBox(width: 168, child: thumbnail);
  }

  Widget _buildThumbnailFallback(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.smart_display_outlined,
          size: 36,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildDurationBadge(BuildContext context, String duration) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(190),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        duration,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildVideoDetails(BuildContext context, VideoModel video) {
    final theme = Theme.of(context);
    final description = video.snippet.description.trim();

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Text(
          video.formattedTitle,
          maxLines: 2,
          overflow: .ellipsis,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5),
        Text(
          _buildVideoMetaLabel(video),
          maxLines: 1,
          overflow: .ellipsis,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (description.isNotEmpty) ...[
          const SizedBox(height: 5),
          Text(
            description,
            maxLines: 2,
            overflow: .ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }

  void _openVideo(VideoModel video, String thumbnailUrl) {
    context.pushNamed(
      Pages.binge.name,
      queryParameters: BingePage.buildParams(
        type: .searchVideos,
        id: _model!.meta.id.toString(),
        videoId: video.video.id,
        heroId: video.video.id,
        heroImg: thumbnailUrl,
      ),
    );
  }

  String _buildVideoMetaLabel(VideoModel video) {
    final views = video.statistics.viewCount;
    if (views == null) {
      return video.snippet.channelTitle;
    }
    return '${video.snippet.channelTitle} - ${_countLabel(views, 'view', 'views')}';
  }

  String _countLabel(int count, String singular, String plural) {
    return '${formatCompactCount(count)} ${count == 1 ? singular : plural}';
  }

  void _resetSearch() {
    setState(() {
      _isValidQuery = false;
      _isLoaded = false;
      _model = null;
    });
  }

  void _processRequest(String? query) async {
    if (!widget.isActive) {
      return;
    }

    final trimmedQuery = query?.trim();
    if (trimmedQuery == null || trimmedQuery.isEmpty) {
      return;
    }
    setState(() {
      _isValidQuery = true;
    });

    Analytics.logSearchVideos();
    SearchVideoWidget._logger.info('Initiating video search for query: $trimmedQuery');
    final videosResult = await YoutubeApi.searchVideos(ref, trimmedQuery);
    if (!mounted) {
      return;
    }
    final model = videosResult.fold((v) => v, (e) => null);
    if (trimmedQuery == widget.query?.trim()) {
      setState(() {
        _model = model;
        _isLoaded = true;
      });
    } else {
      SearchVideoWidget._logger.info(
        'Ignored search results due to user moved to next query:${widget.query} from:$trimmedQuery',
      );
    }
  }
}
