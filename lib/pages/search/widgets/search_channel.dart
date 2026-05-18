import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/db/access/search.dart';
import 'package:bingetube/core/db/models/channel_model.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/channel/channel_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:bingetube/pages/search/widgets/search_formatters.dart';
import 'package:bingetube/pages/search/widgets/search_state_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchChannelWidget extends ConsumerStatefulWidget {
  static final Logger _logger = LogManager.getLogger('SearchChannelWidget');

  final String? query;
  final bool isActive;
  final void Function(ScrollController) scrollListener;

  const SearchChannelWidget(
    this.query, {
    required this.isActive,
    required this.scrollListener,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchChannelState();
}

class _SearchChannelState extends ConsumerState<SearchChannelWidget>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  bool _isValidQuery = false;
  bool _isLoaded = false;
  ChannelSearchModel? _model;

  _SearchChannelState();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_isValidQuery) {
      return const SearchStateView(
        icon: Icons.person_search_outlined,
        title: 'Search channels',
        message: 'Find a creator, then open the channel to add playlists to a series.',
      );
    }

    if (!_isLoaded) {
      return const SearchStateView(
        icon: Icons.person_search_outlined,
        title: 'Searching channels',
        message: 'Looking through YouTube for matching channels.',
        isLoading: true,
      );
    }

    if (_model == null) {
      return SearchStateView(
        icon: Icons.cloud_off_outlined,
        title: 'Search failed',
        message: _searchFailedMessage(),
      );
    }

    final channels = _model!.channels;
    if (channels.isEmpty) {
      return const SearchStateView(
        icon: Icons.search_off_outlined,
        title: 'No channels found',
        message: 'Try a creator name, topic, or a more specific channel title.',
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: channels.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return _buildChannelCard(context, channels[index]);
      },
    );
  }

  Widget _buildChannelCard(BuildContext context, ChannelModel channel) {
    final theme = Theme.of(context);
    final description = channel.snippet.description.trim();

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
        onTap: () => _openChannel(channel),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: channel.channel.id,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundImage: NetworkImage(channel.thumbnails.defaultUrl),
                  child: Icon(
                    Icons.person_outline,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      channel.snippet.title,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 4),
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
                    const SizedBox(height: 6),
                    Text(
                      _buildChannelStatsLabel(channel),
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  void _openChannel(ChannelModel channel) {
    final params = ChannelPage.buildParams(
      channelId: channel.channel.id,
      heroId: channel.channel.id,
      heroImg: channel.thumbnails.defaultUrl,
    );
    context.pushNamed(Pages.channel.name, queryParameters: params);
  }

  String _buildChannelStatsLabel(ChannelModel channel) {
    final stats = channel.statistics;
    final parts = <String>[];

    if (!stats.hiddenSubscriberCount) {
      parts.add(_countLabel(stats.subscriberCount, 'subscriber', 'subscribers'));
    }

    parts.add(_countLabel(stats.videoCount, 'video', 'videos'));
    return parts.join(' - ');
  }

  String _countLabel(int count, String singular, String plural) {
    return '${formatCompactCount(count)} ${count == 1 ? singular : plural}';
  }

  String _searchFailedMessage() {
    final meta = ref.read(ConfigProviders.apiKeyMeta);
    if (meta.isUsingCommunityKey) {
      return 'The community key may be busy or out of quota. Add your own key or try again later.';
    }
    return 'Check your API key or connection, then try again.';
  }

  @override
  void didUpdateWidget(covariant SearchChannelWidget oldWidget) {
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() => widget.scrollListener(_scrollController));
    if (widget.isActive) {
      _processRequest(widget.query);
    }
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

    Analytics.logSearchChannels();
    SearchChannelWidget._logger.info(
      'Initiating channel search for query: $trimmedQuery',
    );
    final channelsResult = await YoutubeApi.searchChannels(ref, trimmedQuery);
    if (!mounted) {
      return;
    }
    if (trimmedQuery == widget.query?.trim()) {
      final channels = channelsResult.fold((l) => l, (e) => null);
      setState(() {
        _model = channels;
        _isLoaded = true;
      });
    } else {
      SearchChannelWidget._logger.info(
        'Ignored search results due to user moved to next query:${widget.query} from:$trimmedQuery',
      );
    }
  }
}
