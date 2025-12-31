import 'package:bingetube/app/routes.dart';
import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/common/widget/refine/refine_widget.dart';
import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/edit_binge/edit_binge_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BingePage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('BingePage');

  final Map<String, String> params;

  const BingePage(this.params, {super.key});

  @override
  ConsumerState createState() => _BingePageState();

  static Map<String, String> buildParams({
    required BingeType type,
    required String id,
    required String videoId,
    required String heroId,
    required String heroImg,
  }) {
    return BingeController.updateParams(
      type: type,
      id: id,
      videoId: videoId,
      heroId: heroId,
      heroImg: heroImg,
    );
  }
}

class _BingePageState extends ConsumerState<BingePage> {
  final _parentScroll = ScrollController();
  final _childScroll = ScrollController();
  late BingeController _controller;

  double _playerHeight = 0;
  bool _isCollapsed = false;

  bool _showRefine = false;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            body: PlayerWidget(
              videoId: _controller.activeVideoId,
              controller: _controller,
              parentScroll: _parentScroll,
              childScroll: _childScroll,
              onEvent: (event, {data}) =>
                  _onPlayerEvent(context, event, data: data),
              slivers: [
                _buildPlaylistHeader(context, snapshot),
                _buildPlaylist(context, snapshot),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaylist(
    BuildContext context,
    AsyncSnapshot<BingeModel> snapshot,
  ) {
    if (snapshot.hasData) {
      final videos = snapshot.data!.videos;
      return SliverList.builder(
        itemCount: videos.length,
        itemBuilder: (context, pos) => _buildVideoCard(context, videos[pos]),
      );
    }
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildPlaylistHeader(
    BuildContext context,
    AsyncSnapshot<BingeModel> snapshot,
  ) {
    double headerHeight = _calcHeaderHeight();
    return SliverPersistentHeader(
      pinned: true,
      delegate: _BingeTitleDelegate(
        minHeight: headerHeight,
        maxHeight: headerHeight,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Column(
            children: [
              Row(
                children: [
                  _buildCollapseIcon(),
                  _buildTitleColumn(snapshot),
                  _buildFilterAndModify(context),
                ],
              ),
              if (_showRefine) ...[
                Container(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: BingeRefineWidget(
                    filter: _controller.filter,
                    sort: _controller.sort,
                    minDateTime: _controller.minDateTime,
                    maxDateTime: _controller.maxDateTime,
                    onFilterUpdate: _onFilterModified,
                    onSortUpdate: _onSortModified,
                    onShowModal: _onRefineOpened,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  double _calcHeaderHeight() {
    final fontSize = ref.read(ConfigProviders.appFontSize);
    final baseHeight = 60.0;
    var headerHeight = _showRefine ? 100.0 : baseHeight;
    if (fontSize == .large) {
      headerHeight += 7.0;
    } else if (fontSize == .small) {
      headerHeight -= 4.0;
    }
    return headerHeight;
  }

  Widget _buildTitleColumn(AsyncSnapshot<BingeModel> snapshot) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              snapshot.data?.title ?? '',
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: .ellipsis,
            ),
            Text(
              '${snapshot.data?.videos.length ?? 0} videos',
              maxLines: 1,
              overflow: .ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapseIcon() {
    return IconButton(
      tooltip: _isCollapsed ? 'Expand' : 'Collapse',
      onPressed: _onCollapsePressed,
      icon: AnimatedRotation(
        turns: _isCollapsed ? 0 : 0.5,
        duration: Duration(milliseconds: 200),
        child: Icon(Icons.expand_less),
      ),
    );
  }

  Widget _buildFilterAndModify(BuildContext context) {
    return Row(
      mainAxisAlignment: .end,
      children: [
        IconButton(
          tooltip: 'Filter & Sort',
          onPressed: _onFilterPressed,
          icon: Icon(Icons.tune),
        ),
        IconButton(
          tooltip: 'Add',
          onPressed: () => _onAddPressed(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildVideoCard(BuildContext context, VideoModel video) {
    final isActive = video.video.id == _controller.activeVideoId;
    return Card(
      color: isActive ? Theme.of(context).colorScheme.primaryContainer : null,
      shape: RoundedRectangleBorder(),
      child: InkWell(
        onTap: isActive ? null : () => _onVideoCardTap(context, video),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              height: 90,
              child: Stack(
                alignment: .bottomCenter,
                children: [
                  Image.network(video.thumbnails.mediumUrl, fit: .cover),
                  if (video.progress.isFinished) ...[
                    LinearProgressIndicator(value: 1),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    video.snippet.title,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w500),
                  ),
                  Text(
                    video.snippet.channelTitle,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w200),
                  ),
                  Text(
                    video.snippet.description,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w300),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: video.progress.isFinished
                  ? 'Mark Unwatched'
                  : 'Mark Watched',
              icon: Icon(
                video.progress.isFinished
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () => _controller.setVideoWatched(
                video,
                !video.progress.isFinished,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  void _onVideoCardTap(BuildContext context, VideoModel video) {
    setState(() {
      _controller.setActiveVideoId(video.video.id);
    });
  }

  void _onPlayerEvent(
    BuildContext context,
    PlayerEventType eventType, {
    Object? data,
  }) {
    switch (eventType) {
      case .onBack:
        Routes.popOrHome(context);
        break;
      case .onPrev:
        setState(() {
          _controller.setPrevVideo();
          updateQueryParams(context);
        });
        _scrollToActiveVideo();
        break;
      case .onNext:
        setState(() {
          _controller.setNextVideo();
          updateQueryParams(context);
        });
        _scrollToActiveVideo();
        break;
      case .onHeight:
        _playerHeight = data as double;
        break;
      case .onScrollEnd:
        _updateCollapseState();
        break;
      default:
        BingePage._logger.warning('unhandled eventType:$eventType');
    }
  }

  void updateQueryParams(BuildContext context) {
    context.goNamed(
      Pages.binge.name,
      queryParameters: BingeController.updateParams(
        baseParams: widget.params,
        videoId: _controller.activeVideoId,
        heroId: _controller.heroId,
        heroImg: _controller.heroImg,
      ),
    );
  }

  void _scrollToActiveVideo() {
    const headerHeight = 0;
    const itemHeight = 98.0;
    final currPos = _controller.activeVideoPos!;
    _childScroll.animateTo(
      headerHeight + (currPos * itemHeight),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _onCollapsePressed() {
    _parentScroll.animateTo(
      _isCollapsed ? _playerHeight : 0,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  void _updateCollapseState() {
    setState(() {
      _isCollapsed = _parentScroll.offset == 0;
    });
  }

  void _onFilterPressed() {
    setState(() {
      if (_showRefine) {
        _controller.setFilter(BingeFilter.defaultValue);
        _controller.setSort(BingeSort.defaultValue);
      }
      _showRefine = !_showRefine;
    });
  }

  void _onFilterModified(BingeFilter filter) {
    setState(() {
      _controller.setFilter(filter);
    });
  }

  void _onSortModified(BingeSort sort) {
    setState(() {
      _controller.setSort(sort);
    });
  }

  void _onRefineOpened() {
    if (_isCollapsed) {
      _onCollapsePressed();
    }
  }

  void _onAddPressed(BuildContext context) {
    context.pushNamed(
      Pages.editBinge.name,
      queryParameters: EditBingePage.buildParams(widget.params),
    );
  }
}

// Reuse the same delegate from before
class _BingeTitleDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _BingeTitleDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_BingeTitleDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
