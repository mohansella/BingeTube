import 'dart:math' as math;
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bingetube/app/theme.dart';
import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';

abstract class BasePlayerWidget extends PlayerWidget {
  static final _logger = LogManager.getLogger('BasePlayerWidget');

  const BasePlayerWidget({
    super.key,
    required super.videoId,
    required super.controller,
    required super.parentScroll,
    required super.childScroll,
    required super.onEvent,
    required super.slivers,
    required super.isCollapsed,
  }) : super.internal();

  @override
  BasePlayerState createState();
}

abstract class BasePlayerState extends ConsumerState<BasePlayerWidget> {
  VideoModel? get model => _model;
  double get playerWidth => _width;
  double get playerHeight => _height;
  BingeController get controller => widget.controller;

  VideoModel? _model;
  bool _loading = true;
  Object? _error;

  double _width = 0;
  double _height = 0;

  ScrollController get _parentScroll => widget.parentScroll;
  ScrollController get _childScroll => widget.childScroll;

  Widget buildMedia();
  Widget buildPlayPause();

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
        widget.onEvent(.onHeight, data: _height);
        return NotificationListener<ScrollEndNotification>(
          onNotification: _scrollEndListener,
          child: NestedScrollView(
            controller: _parentScroll,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: _height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: _buildPlayerStack(),
                      ),
                    ),
                  ];
                },
            body: NotificationListener<ScrollNotification>(
              onNotification: _onChildScroll,
              child: CustomScrollView(
                controller: _childScroll,
                slivers: widget.slivers, //SliverList
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    restartState();
  }

  int _restartId = 0;
  void restartState() async {
    _loading = true;
    _model = null;
    _error = null;
    final restartId = ++_restartId;
    try {
      final value = await controller.getActiveVideoModel();
      if (restartId == _restartId) {
        setState(() {
          _model = value;
          _loading = false;
        });
        if (_parentScroll.hasClients) {
          _parentScroll.animateTo(
            0.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      } else {
        BasePlayerWidget._logger.shout(
          'restartState skipped since user navigated to another:$_restartId from:$restartId',
        );
      }
    } catch (e) {
      BasePlayerWidget._logger.shout('getActiveVideoModel causes error:', e);
      if (restartId == _restartId) {
        setState(() {
          _error = e;
          _loading = false;
        });
      }
      rethrow;
    }
  }

  @override
  void didUpdateWidget(covariant BasePlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      restartState();
    }
  }

  Widget buildControls(BuildContext context) {
    final w = math.min(math.max(400, _width), 600);
    final appFontSize = ref.read(ConfigProviders.appFontSize);
    final theme = Themes.dark(appFontSize);
    return Stack(
      children: [
        _buildTopGradient(),
        Theme(
          data: theme,
          child: Padding(
            padding: EdgeInsets.all(w / 40),
            child: Stack(
              children: [
                InkWell(
                  onTap: () => widget.onEvent(.onBack),
                  child: Tooltip(
                    message: 'Back',
                    child: Icon(Icons.arrow_back, size: w / 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w / 14),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        _model?.snippet.title ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: w / 30,
                        ),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                      Text(
                        _model?.snippet.channelTitle ?? '',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: w / 40,
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
                        padding: EdgeInsets.symmetric(horizontal: w / 14),
                        child: buildPlayPause(),
                      ),
                      buildSkipNext(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildIconControl(
    void Function()? onTap,
    IconData icon,
    double size,
    String tooltip, {
    bool colorDecoration = true,
    String? text,
    TextStyle? textStyle,
  }) {
    return InkWell(
      onTap: onTap,
      child: Tooltip(
        margin: EdgeInsets.only(top: 8),
        message: tooltip,
        child: Container(
          decoration: BoxDecoration(
            color: colorDecoration ? Colors.black.withAlpha(140) : null,
            shape: .circle,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: size,
                color: onTap == null ? Colors.white30 : Colors.white,
              ),
              if (text != null) ...[Text(text, style: textStyle)],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerStack() {
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: Stack(
        fit: .expand,
        children: [
          //ColoredBox(color: Colors.black),
          buildMedia(),
          if (_loading) ...[
            Center(child: CircularProgressIndicator()),
          ] else if (_error != null) ...[
            Center(child: Text('error: $_error')),
          ],
          buildControls(context),
        ],
      ),
    );
  }

  Widget buildSkipNext() {
    final isEnabled = controller.isNextVideoExists;
    return buildIconControl(
      isEnabled ? () => widget.onEvent(.onNext) : null,
      Icons.skip_next,
      _width / 14,
      'Next',
    );
  }

  Widget _buildSkipPrevious() {
    final isEnabled = controller.isPrevVideoExists;
    return buildIconControl(
      isEnabled ? () => widget.onEvent(.onPrev) : null,
      Icons.skip_previous,
      _width / 14,
      'Previous',
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

  bool _scrollEndListener(notification) {
    BasePlayerWidget._logger.finer(
      'depth:${notification.depth} parent:${_parentScroll.offset} child:${_childScroll.offset}',
    );
    widget.onEvent(.onScrollEnd);
    bool toReturn = false;
    if (notification.depth != 0) {
      return toReturn;
    }
    final offset = _parentScroll.offset;
    if (_parentScroll.position.atEdge && offset != 0) {
      return toReturn;
    }
    Future.microtask(() {
      if (offset > 0 && offset < _height) {
        if (offset > _height / 2) {
          _parentScroll.animateTo(
            _height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        } else {
          _parentScroll.animateTo(
            0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      }
    });
    return toReturn;
  }

  bool _onChildScroll(ScrollNotification notification) {
    final offset = _childScroll.offset;
    if (offset < 0 && _parentScroll.offset > 0) {
      Future.microtask(() {
        _parentScroll.animateTo(
          0.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
        _childScroll.animateTo(
          0.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
    return false;
  }
}
