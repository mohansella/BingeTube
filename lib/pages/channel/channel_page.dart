import 'package:bingetube/app/theme.dart';
import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/constants/constants.dart';
import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/access/playlists.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/channel_model.dart';
import 'package:bingetube/core/db/tables/playlists.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/model_utils.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

enum _Params { channelId, heroId, heroImg }

class ChannelPage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('ChannelPage');

  final Map<String, String> queryParameters;

  const ChannelPage(this.queryParameters, {super.key});

  static Map<String, String> buildParams({
    required String channelId,
    required String heroId,
    required String heroImg,
  }) {
    return <_Params, String>{
      .channelId: channelId,
      .heroId: heroId,
      .heroImg: heroImg,
    }.map((k, v) => MapEntry(k.name, v));
  }

  @override
  ConsumerState<ChannelPage> createState() => _ChannelPageState();

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .channel,
      customBuilder: (_, s) => ChannelPage(s.uri.queryParameters),
    );
  }
}

class _ChannelPageState extends ConsumerState<ChannelPage> {
  final _channelDao = ChannelsDao(Database());
  final _playlistDao = PlaylistsDao(Database());
  final _searchController = TextEditingController();

  late String _channelId;
  late String _heroId;
  late String _heroImg;

  bool _isModelLoading = true;
  bool _isFetchTriggered = false;
  late ChannelModel _model;

  bool _isFetchInProgress = false;
  int _fetchCount = 0;
  int _fetchTotal = 1;

  String _searchQuery = '';
  double get _progress {
    if (_fetchTotal == 0) return 0;
    return (_fetchCount / _fetchTotal).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();
    final params = widget.queryParameters;
    _channelId = params[_Params.channelId.name]!;
    _heroId = params[_Params.heroId.name]!;
    _heroImg = params[_Params.heroImg.name]!;

    _channelDao.getChannelModelById(_channelId).then((v) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isModelLoading = false;
        _model = v;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: StreamBuilder(
          stream: _playlistDao.streamPlaylistModels(_channelId),
          builder: (context, snapshot) {
            final allPlaylists = snapshot.hasData
                ? _buildOrderedPlaylists(snapshot.data!)
                : null;
            final filteredPlaylists = allPlaylists == null
                ? null
                : _filterPlaylists(allPlaylists);
            final isSyncQueued =
                allPlaylists != null &&
                !_isFetchTriggered &&
                _shouldSyncPlaylists(allPlaylists);
            final isSyncingOrQueued = _isFetchInProgress || isSyncQueued;

            if (allPlaylists != null) {
              _triggerSyncIfNeeded(allPlaylists);
            }

            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(context),
                SliverToBoxAdapter(child: _buildChannelInfo()),
                SliverToBoxAdapter(child: _buildProgress()),
                SliverToBoxAdapter(child: _buildSearchField()),
                if (filteredPlaylists == null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildStateView(
                      icon: Icons.playlist_play_outlined,
                      title: 'Loading playlists',
                      message: 'Getting this channel ready.',
                      isLoading: true,
                    ),
                  )
                else if (filteredPlaylists.isEmpty &&
                    isSyncingOrQueued &&
                    _searchQuery.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildStateView(
                      icon: Icons.playlist_play_outlined,
                      title: 'Updating playlists',
                      message: 'Fresh playlist data is on the way.',
                      isLoading: true,
                    ),
                  )
                else if (filteredPlaylists.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildStateView(
                      icon: _searchQuery.isEmpty
                          ? Icons.playlist_remove_outlined
                          : Icons.search_off_outlined,
                      title: _searchQuery.isEmpty
                          ? 'No playlists yet'
                          : 'No matching playlists',
                      message: _searchQuery.isEmpty
                          ? 'This channel has no synced playlists available.'
                          : 'Try another playlist title or description.',
                    ),
                  )
                else
                  _buildPlaylistSliver(filteredPlaylists),
              ],
            );
          },
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    final title = _isModelLoading ? 'Channel' : _model.snippet.title;

    return SliverAppBar(
      pinned: true,
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }

  List<PlaylistModel> _buildOrderedPlaylists(PlaylistModels data) {
    var list = data.normals;
    if (data.uploads != null) {
      list = [data.uploads!, ...list];
    }
    if (data.likes != null) {
      list = [data.likes!, ...list];
    }
    return list;
  }

  List<PlaylistModel> _filterPlaylists(List<PlaylistModel> list) {
    final query = _searchQuery.toLowerCase();
    if (query.isEmpty) {
      return list;
    }

    return list.where((playlist) {
      final title = playlist.snippet.title.toLowerCase();
      final description = playlist.snippet.description.toLowerCase();
      return title.contains(query) || description.contains(query);
    }).toList();
  }

  Widget _buildChannelInfo() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 420;
          final avatar = Hero(
            tag: _heroId,
            child: ClipOval(
              child: SizedBox(
                width: 84,
                height: 84,
                child: _buildChannelImage(_heroImg, _heroId),
              ),
            ),
          );
          final details = _buildChannelDetails(theme);

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [avatar, const SizedBox(height: 12), details],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              avatar,
              const SizedBox(width: 16),
              Expanded(child: details),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChannelDetails(ThemeData theme) {
    if (_isModelLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Loading channel...',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Syncing channel details and playlists.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

    final description = _model.snippet.description.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _model.snippet.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: _buildStatChips(theme)),
        if (description.isNotEmpty) ...[
          const SizedBox(height: 12),
          ReadMoreText(
            description,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' more',
            trimExpandedText: ' less',
            colorClickableText: theme.colorScheme.primary,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildStatChips(ThemeData theme) {
    final stats = _model.statistics;
    final chips = <Widget>[];
    if (!stats.hiddenSubscriberCount) {
      chips.add(
        _buildStatChip(
          theme,
          Icons.people_outline,
          _countLabel(stats.subscriberCount, 'subscriber', 'subscribers'),
        ),
      );
    }
    chips.add(
      _buildStatChip(
        theme,
        Icons.smart_display_outlined,
        _countLabel(stats.videoCount, 'video', 'videos'),
      ),
    );
    return chips;
  }

  Widget _buildStatChip(ThemeData theme, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSecondaryContainer),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    final theme = Theme.of(context);

    if (!_isFetchInProgress) {
      return const SizedBox(height: 10);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(value: _progress, minHeight: 6),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.sync, size: 16, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Updating playlists: $_fetchCount of $_fetchTotal',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStateView({
    required IconData icon,
    required String title,
    required String message,
    bool isLoading = false,
  }) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 96),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    )
                  : Icon(icon, size: 30, color: theme.colorScheme.onSecondaryContainer),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    if (_isFetchInProgress) {
      return const SizedBox(height: 8);
    }

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search playlists',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Clear search',
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.close),
                ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        onChanged: (value) => setState(() => _searchQuery = value.trim()),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  SliverPadding _buildPlaylistSliver(List<PlaylistModel> list) {
    final itemCount = list.isEmpty ? 0 : list.length * 2 - 1;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
      sliver: SliverList.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return const SizedBox(height: 8);
          }
          return _buildPlaylistCard(context, list[index ~/ 2]);
        },
      ),
    );
  }

  Widget _buildPlaylistCard(BuildContext context, PlaylistModel model) {
    final theme = Theme.of(context);
    final thumb = model.thumbnails;
    final imgUrl = ModelUtils.selectImageUrl([
      thumb.highUrl,
      thumb.mediumUrl,
      thumb.defaultUrl,
    ]);

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
        onTap: () => _onTapPlaylist(model, imgUrl),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 430;
            final image = _buildPlaylistImages(model, imgUrl, isNarrow: isNarrow);
            final details = _buildPlaylistDetails(context, model);

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  image,
                  Padding(padding: const EdgeInsets.all(12), child: details),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image,
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

  Widget _buildPlaylistDetails(BuildContext context, PlaylistModel model) {
    final theme = Theme.of(context);
    final description = model.snippet.description.trim();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildPlaylistTypeIcon(context, model),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                model.snippet.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          _playlistVideoCountLabel(model.details.itemCount),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPlaylistTypeIcon(BuildContext context, PlaylistModel model) {
    final theme = Theme.of(context);
    final icon = switch (model.playlist.type) {
      PlaylistType.uploads => Icons.video_library_outlined,
      PlaylistType.likes => Icons.thumb_up_alt_outlined,
      PlaylistType.normal => Icons.playlist_play_outlined,
    };

    return Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant);
  }

  Widget _buildPlaylistImages(
    PlaylistModel model,
    String imgUrl, {
    required bool isNarrow,
  }) {
    final id = model.playlist.id;
    final imageStack = AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildPlaylistImageFallback(id, alpha: 0.5),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildPlaylistImageFallback(id, alpha: 0.9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(tag: id, child: _buildPlaylistImage(model, imgUrl)),
            ),
          ),
        ],
      ),
    );

    if (isNarrow) {
      return imageStack;
    }
    return SizedBox(width: 168, child: imageStack);
  }

  Widget _buildPlaylistImage(PlaylistModel model, String imgUrl) {
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      frameBuilder: (c, child, frame, wasSyncLoaded) {
        if (frame != null || wasSyncLoaded) {
          return child;
        }
        return _buildPlaylistImageFallback(model.snippet.id);
      },
      errorBuilder: (c, _, _) => _buildPlaylistImageFallback(model.snippet.id),
    );
  }

  Widget _buildPlaylistImageFallback(String id, {double alpha = 1.0}) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(id, brightness, alpha: alpha, sat: 0.1);
    return Container(
      color: color,
      alignment: Alignment.center,
      child: alpha >= 0.99
          ? Icon(Icons.playlist_play_outlined, color: theme.colorScheme.onSurfaceVariant)
          : null,
    );
  }

  Future<void> _triggerSyncIfNeeded(List<PlaylistModel> list) async {
    if (_isFetchTriggered) {
      return;
    }
    final isAnyExpired = _hasExpiredPlaylists(list);

    if (list.isEmpty || isAnyExpired) {
      _isFetchTriggered = true;
      await Future.delayed(Duration.zero);
      if (!mounted) {
        return;
      }
      setState(() {
        _isFetchInProgress = true;
        _fetchCount = 0;
        _fetchTotal = 1;
      });
      ChannelPage._logger.info(
        'triggering fetch. isAnyExpired:$isAnyExpired existing length:${list.length}',
      );
      YoutubeApi.syncPlaylist(ref, _channelId, (count, total) {
        if (!mounted) {
          return false;
        }
        setState(() {
          _fetchCount = count;
          _fetchTotal = total;
        });
        return context.mounted;
      }).whenComplete(() {
        if (!mounted) {
          return;
        }
        setState(() {
          _isFetchInProgress = false;
        });
      });
    }
  }

  bool _shouldSyncPlaylists(List<PlaylistModel> list) {
    return list.isEmpty || _hasExpiredPlaylists(list);
  }

  bool _hasExpiredPlaylists(List<PlaylistModel> list) {
    final nowTime = DateTime.now();
    return list.any((p) {
      final expiresAt = p.playlist.updatedAt.add(
        CacheConstants.syncChannelSearchResultAfter,
      );
      return expiresAt.isBefore(nowTime);
    });
  }

  Widget _buildChannelImage(String url, String id) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      frameBuilder: (_, child, frame, wasSyncLoaded) {
        if (frame != null || wasSyncLoaded) {
          return child;
        }
        return _buildChannelImageFallback(id);
      },
      errorBuilder: (c, _, _) => _buildChannelImageFallback(id),
    );
  }

  Widget _buildChannelImageFallback(String id) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(id, brightness);
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Icon(Icons.person_outline, color: theme.colorScheme.onSurfaceVariant),
    );
  }

  void _onTapPlaylist(PlaylistModel model, String imgUrl) async {
    final id = model.playlist.id;
    final isCompleted = await _syncVideosWithCustomDialogProgress(model);
    if (!isCompleted) {
      return;
    }

    try {
      final firstVideo = await _playlistDao.getFirstVideoModel(id);
      final localContext = context;
      if (localContext.mounted) {
        localContext.pushNamed(
          Pages.binge.name,
          queryParameters: BingePage.buildParams(
            type: .playlistVideos,
            id: id,
            videoId: firstVideo.video.id,
            heroId: id,
            heroImg: imgUrl,
          ),
        );
      }
    } catch (e) {
      final localContext = context;
      if (localContext.mounted) {
        CustomDialog.show(
          localContext,
          'No videos available',
          'Okay',
          const Text('This playlist does not have any synced videos to play.'),
        );
      }
    }
  }

  Future<bool> _syncVideosWithCustomDialogProgress(PlaylistModel model) async {
    var isSync = false;
    var progress = 0;
    var end = 1;

    bool Function(bool, int, int) callback = (s, p, e) => true;
    bool callbackWrapper(s, p, e) => callback(s, p, e);
    final future = YoutubeApi.syncPlaylistVideos(ref, model.playlist.id, callbackWrapper);

    final isCancelled = await CustomDialog.show(
      context,
      'Syncing Playlist',
      'Cancel',
      FutureBuilder(
        future: future,
        builder: (fContext, snapshot) {
          if (snapshot.hasData && fContext.mounted) {
            Future.microtask(() {
              if (fContext.mounted) fContext.pop();
            });
          }
          return StatefulBuilder(
            builder: (localContext, setLocalState) {
              callback = (s, p, e) {
                Future.microtask(() {
                  if (!localContext.mounted) return;
                  setLocalState(() {
                    isSync = s;
                    progress = p;
                    end = e <= 0 ? 1 : e;
                  });
                });
                return localContext.mounted;
              };
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$progress of $end items ${isSync ? "synchronized" : "fetched"}'),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: progress / end),
                ],
              );
            },
          );
        },
      ),
    );
    ChannelPage._logger.info('playlist sync dialog closed. isCancelled:$isCancelled');
    return !isCancelled;
  }

  String _playlistVideoCountLabel(int count) {
    return _countLabel(count, 'video', 'videos');
  }

  String _countLabel(int count, String singular, String plural) {
    return '${_formatCompactCount(count)} ${count == 1 ? singular : plural}';
  }

  String _formatCompactCount(int value) {
    if (value < 1000) {
      return value.toString();
    }

    if (value >= 1000000000) {
      return '${_formatCompactValue(value / 1000000000)}B';
    }
    if (value >= 1000000) {
      return '${_formatCompactValue(value / 1000000)}M';
    }
    return '${_formatCompactValue(value / 1000)}K';
  }

  String _formatCompactValue(double value) {
    final formatted = value >= 10 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
    return formatted.replaceFirst(RegExp(r'\.0$'), '');
  }
}
