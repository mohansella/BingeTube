import 'package:bingetube/app/theme.dart';
import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalPlayerWidget extends PlayerWidget {
  static final _logger = LogManager.getLogger('ExternalPlayerWidget');

  const ExternalPlayerWidget({
    super.key,
    required super.controller,
    required super.onBack,
    required super.child,
  }) : super.internal();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExternalPlayerState();
}

class _ExternalPlayerState extends ConsumerState<ExternalPlayerWidget> {
  VideoModel? _model;
  bool _loading = true;
  Object? _error;

  double _width = 0;
  double _height = 0;

  bool _isExternallyOpened = false;
  bool _isMarkWatched = false;

  final _scrollController = ScrollController();
  BingeController get controller => widget.controller;
  VideoModel get model => _model!;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final aspectWidth = constrains.maxHeight * 16.0 / 9.0;
        final aspectHeight = constrains.maxWidth * 9.0 / 16.0;
        final maxWidth = constrains.maxWidth;
        final maxHeight = constrains.maxHeight;
        if (aspectWidth < maxWidth) {
          _width = aspectWidth;
          _height = constrains.maxHeight;
        } else {
          _width = constrains.maxWidth;
          _height = aspectHeight < maxHeight ? aspectHeight : maxHeight;
        }
        return NotificationListener<ScrollEndNotification>(
          onNotification: _scrollEndListener,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: _height,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildPlayerStack(),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _PlaylistTitleDelegate(
                  minHeight: 60.0,
                  maxHeight: 60.0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.grey,
                    child: Text('Title'),
                  ),
                ),
              ),
              SliverList.list(
                children: List.generate(
                  100,
                  (i) => Text('$i', textAlign: .center),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller
        .getActiveVideoModel()
        .then((value) {
          setState(() {
            _model = value;
            _loading = false;
          });
        })
        .catchError((e) {
          setState(() {
            _error = e;
            _loading = false;
          });
        });
  }

  Widget _buildControls(BuildContext context) {
    final appFontSize = ref.read(ConfigProviders.appFontSize);
    final theme = Themes.dark(appFontSize);
    return Theme(
      data: theme,
      child: Padding(
        padding: EdgeInsets.all(_width / 40),
        child: Stack(
          children: [
            InkWell(
              onTap: widget.onBack,
              child: Tooltip(
                message: 'back',
                child: Icon(Icons.arrow_back, size: _width / 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: _width / 14),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    model.snippet.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: _width / 30,
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  Text(
                    model.snippet.channelTitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: _width / 40,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  _buildSkipPrevious(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _width / 14),
                    child: _buildPlayAndOthers(theme),
                  ),
                  _buildSkipNext(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconControl(void Function()? onTap, IconData icon, double size) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(140),
          shape: .circle,
        ),
        child: Icon(
          icon,
          size: size,
          color: onTap == null ? Colors.white30 : Colors.white,
        ),
      ),
    );
  }

  Widget _buildPlayAndOthers(ThemeData theme) {
    return _buildIconControl(
      () => _openExternally(),
      _isExternallyOpened ? Icons.replay : Icons.play_arrow,
      _width / 10,
    );
  }

  Widget _buildPlayerStack() {
    final imageUrl =
        _model?.thumbnails.maxresUrl ??
        _model?.thumbnails.standardUrl ??
        _model?.thumbnails.highUrl;
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: Stack(
        fit: .expand,
        children: [
          ColoredBox(color: Colors.black),
          _buildTopGradient(),
          if (_model == null) ...[
            Center(child: CircularProgressIndicator()),
          ] else ...[
            Image.network(imageUrl!, fit: .contain),
            _buildControls(context),
          ],
        ],
      ),
    );
  }

  Widget _buildSkipNext() {
    final isEnabled = controller.isPrevVideoExists;
    if (_isExternallyOpened) {
      return _buildIconControl(
        _isMarkWatched
            ? null
            : () {
                setState(() {
                  _isMarkWatched = true;
                });
                controller.markVideoWatched();
              },
        Icons.check_outlined,
        _width / 14,
      );
    }
    return _buildIconControl(
      isEnabled ? () {} : null,
      Icons.skip_next,
      _width / 14,
    );
  }

  Widget _buildSkipPrevious() {
    final isEnabled = controller.isNextVideoExists;
    return _buildIconControl(
      isEnabled ? () {} : null,
      Icons.skip_previous,
      _width / 14,
    );
  }

  Container _buildTopGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.25],
          colors: [Colors.black.withAlpha(200), Colors.transparent],
        ),
      ),
    );
  }

  Future<void> _openExternally() async {
    setState(() {
      _isExternallyOpened = true;
    });
    ExternalPlayerWidget._logger.info(
      'opening externally id:${model.video.id} title: ${model.snippet.title}',
    );
    final url = Uri.parse('https://www.youtube.com/watch?v=${model.video.id}');
    controller.markVideoStarted();
    await launchUrl(url);
  }

  bool _scrollEndListener(notification) {
    if (notification.depth == 0) {
      final offset = _scrollController.offset;
      Future.microtask(() {
        if (offset > 0 && offset < _height) {
          if (offset > _height / 2) {
            _scrollController.animateTo(
              _height,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          } else {
            _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
        }
      });
    }
    return false;
  }
}

// Reuse the same delegate from before
class _PlaylistTitleDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _PlaylistTitleDelegate({
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
  bool shouldRebuild(_PlaylistTitleDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
