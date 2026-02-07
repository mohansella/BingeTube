import 'dart:io';
import 'package:bingetube/app/routes.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:bingetube/common/widget/player/base_player_widget.dart';
import 'package:bingetube/common/widget/player/server/player_server.dart';
import 'package:url_launcher/url_launcher.dart';

class InternalPlayerWidget extends BasePlayerWidget {
  static final _logger = LogManager.getLogger('InternalPlayerWidget');

  const InternalPlayerWidget({
    super.key,
    required super.videoId,
    required super.controller,
    required super.parentScroll,
    required super.childScroll,
    required super.onEvent,
    required super.slivers,
    required super.isCollapsed,
  });

  @override
  BasePlayerState createState() => _InternalPlayerState();

  static get isSupportedPlatform {
    return Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isWindows;
  }
}

class _InternalPlayerState extends BasePlayerState {
  _VideoController? _videoController;

  _PlayState _playState = .loading;

  @override
  void restartState() {
    _playState = .loading;
    super.restartState();
  }

  @override
  void didUpdateWidget(covariant InternalPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoId != widget.videoId) {
      _videoController?.loadVideo(widget.videoId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (InternalPlayerWidget.isSupportedPlatform) {
      return _buildSupported(context);
    }
    return _buildNotSupported();
  }

  @override
  Widget buildPlayPause() {
    final size = playerWidth / 10;
    switch (_playState) {
      case .loading:
        return CircularProgressIndicator();
      case .paused:
        return buildIconControl(_onPlayTap, Icons.play_arrow, size, 'Play');
      case .playing:
        return buildIconControl(
          _onPauseTap,
          Icons.pause_outlined,
          size,
          'Pause',
        );
    }
  }

  @override
  Widget buildMedia() {
    return _buildWebView();
  }

  @override
  Widget buildControls(BuildContext context) {
    return SizedBox();
  }

  InAppWebView _buildWebView() {
    final url = 'http://localhost:${PlayerServer().port}?id=${widget.videoId}';
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        useShouldOverrideUrlLoading: true,
      ),
      onWebViewCreated: (webControl) {
        initController(webControl);
      },
      shouldOverrideUrlLoading: (_, action) async {
        final uri = action.request.url;
        final allowedPrefix = [
          'http://localhost',
          'about:blank',
          'https://www.youtube.com/embed/',
        ];
        if (uri != null) {
          final url = uri.toString();
          if (!allowedPrefix.any((p) => url.startsWith(p))) {
            launchUrl(uri);
            InternalPlayerWidget._logger.warning('Attempted navigation: $url');
            return NavigationActionPolicy.CANCEL;
          }
        }
        return NavigationActionPolicy.ALLOW;
      },
    );
  }

  Widget _buildSupported(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: super.build(context));
  }

  AppBar? _buildAppBar() {
    if (!widget.isCollapsed) {
      return null;
    }
    final iconSize = 28.0;
    final style = TextStyle(fontSize: 14);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          buildIconControl(
            () => Routes.popOrHome(context),
            Icons.arrow_back,
            iconSize,
            'Back',
            colorDecoration: false,
          ),
          buildIconControl(
            controller.isPrevVideoExists ? () => widget.onEvent(.onPrev) : null,
            Icons.skip_previous,
            iconSize,
            'Skip Previous',
            colorDecoration: false,
            text: 'Previous Ep.',
            textStyle: style,
          ),
          buildIconControl(
            controller.isNextVideoExists ? () => widget.onEvent(.onNext) : null,
            Icons.skip_next,
            iconSize,
            'Skip Next',
            colorDecoration: false,
            text: 'Next Ep.',
            textStyle: style,
          ),
          buildIconControl(
            () => widget.onEvent(.onListToggle),
            Icons.video_library_outlined,
            iconSize - 5,
            'Episodes',
            text: 'All Ep.',
            colorDecoration: false,
            textStyle: style,
          ),
        ],
      ),
    );
  }

  Widget _buildNotSupported() {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Internal player currently not support for this platform'),
    );
  }

  void initController(InAppWebViewController webControl) {
    if (_videoController != null) return;
    _videoController = _VideoController(this, webControl);
  }

  void _onPlayTap() async {
    await _videoController?.playVideo();
    setState(() {
      _playState = .playing;
    });
  }

  void _onPauseTap() async {
    await _videoController?.pauseVideo();
    setState(() {
      _playState = .paused;
    });
  }

  void _onWebPlayerReady() async {
    setState(() {
      _playState = .paused;
    });
    await _videoController?.startProgressTracking();
  }

  void _onWebPlayerProgress(data) {
    double getData(String key) {
      return double.parse(data[key].toString());
    }

    final current = getData('current');
    final duration = getData('duration');
    final progress = getData('progress');
    InternalPlayerWidget._logger.finer(
      'progress:$progress current:$current duration:$duration',
    );

    if (duration - current < 0) {
      if (controller.isNextVideoExists) {
        widget.onEvent(.onNext);
      }
    }
  }

  void _onWebPlayerStateChange(data) {}
  void _onWebPlayerQualityChange(data) {}
  void _onWebPlayerRateChange(data) {}
  void _onWebPlayerError(data) {}
}

class _VideoController {
  final InAppWebViewController controller;
  final _InternalPlayerState state;

  _VideoController(this.state, this.controller) {
    controller.addJavaScriptHandler(
      handlerName: 'appBridge',
      callback: _callbackFromJS,
    );
  }

  dynamic _callbackFromJS(List<dynamic> args) {
    final data = args.first as Map;
    final event = data['event'] as String;
    final payload = data['payload'];
    switch (event) {
      case 'onReady':
        return state._onWebPlayerReady();
      case 'onStateChange':
        return state._onWebPlayerStateChange(payload);
      case 'onQualityChange':
        return state._onWebPlayerQualityChange(payload);
      case 'onRateChange':
        return state._onWebPlayerRateChange(payload);
      case 'onError':
        return state._onWebPlayerError(payload);
      case 'onProgress':
        return state._onWebPlayerProgress(payload);
    }
    InternalPlayerWidget._logger.warning('unhandled event from web: $data');
  }

  void loadVideo(String videoId) {
    final port = PlayerServer().port;
    final newUrl = 'http://localhost:$port?id=$videoId';
    controller.loadUrl(urlRequest: URLRequest(url: WebUri(newUrl)));
  }

  Future<void> pauseVideo() {
    return controller.evaluateJavascript(source: 'player.pauseVideo()');
  }

  Future<void> playVideo() {
    return controller.evaluateJavascript(source: 'player.playVideo()');
  }

  Future<void> startProgressTracking() {
    return controller.evaluateJavascript(source: 'startProgressTracking()');
  }
}

enum _PlayState { loading, paused, playing }
