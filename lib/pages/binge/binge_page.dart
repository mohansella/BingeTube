import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class BingePage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('BingePage');

  final Map<String, String> params;

  const BingePage(this.params, {super.key});

  @override
  ConsumerState createState() => _BingePageState();
}

class _BingePageState extends ConsumerState<BingePage> {
  final _parentScroll = ScrollController();
  final _childScroll = ScrollController();
  late BingeController _controller;

  double _playerHeight = 0;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
  }

  @override
  void didUpdateWidget(covariant BingePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerWidget(
        videoId: _controller.activeVideoId,
        controller: _controller,
        parentScroll: _parentScroll,
        childScroll: _childScroll,
        onEvent: (event, {data}) => _onPlayerEvent(context, event, data: data),
        slivers: [_buildPlaylistHeader(context), _buildPlaylist()],
      ),
    );
  }

  Widget _buildPlaylist() {
    return StreamBuilder(
      stream: _controller.streamBingeModel(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final videos = snapshot.data!.videos;
          return SliverList.builder(
            itemCount: videos.length,
            itemBuilder: (context, pos) =>
                _buildVideoCard(context, videos[pos]),
          );
        }
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget _buildPlaylistHeader(BuildContext context) {
    return StreamBuilder(
      stream: _controller.streamBingeModel(),
      builder: (context, snapshot) {
        return SliverPersistentHeader(
          pinned: true,
          delegate: _BingeTitleDelegate(
            minHeight: 64,
            maxHeight: 64,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(
                children: [
                  Align(
                    alignment: .centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: IconButton(
                        onPressed: _onCollapsePressed,
                        icon: AnimatedRotation(
                          turns: _isCollapsed ? 0 : 0.5,
                          duration: Duration(milliseconds: 200),
                          child: Icon(Icons.expand_less),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          snapshot.data?.title ?? '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text('${snapshot.data?.videos.length ?? 0} videos'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Card _buildVideoCard(BuildContext context, VideoModel video) {
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
    context.replace(
      BingeController.buildPath(
        type: .searchVideos,
        id: video.video.id,
        heroId: video.video.id,
        heroImg: video.thumbnails.mediumUrl,
      ),
    );
  }

  void _onPlayerEvent(
    BuildContext context,
    PlayerEventType eventType, {
    Object? data,
  }) {
    switch (eventType) {
      case .onBack:
        Navigator.pop(context);
        break;
      case .onPrev:
        setState(() {
          _controller.setPrevVideo();
        });
        _scrollToActiveVideo();
        break;
      case .onNext:
        setState(() {
          _controller.setNextVideo();
        });
        _scrollToActiveVideo();
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
