import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:bingetube/common/widget/player/base_player_widget.dart';
import 'package:bingetube/common/widget/player/server/player_server.dart';

class InternalPlayerWidget extends BasePlayerWidget {
  const InternalPlayerWidget({
    super.key,
    required super.videoId,
    required super.controller,
    required super.parentScroll,
    required super.childScroll,
    required super.onEvent,
    required super.slivers,
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

  bool _isPlaying = true;

  @override
  void restartState() {
    _isPlaying = true;
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
    return buildIconControl(
      _onPlayPause,
      _isPlaying ? Icons.pause_outlined : Icons.play_arrow,
      playerWidth / 10,
      'Play',
    );
  }

  @override
  Widget buildMedia() {
    return _buildWebView();
  }

  InAppWebView _buildWebView() {
    final url = 'http://localhost:${PlayerServer().port}?id=${widget.videoId}';
    return InAppWebView(
    initialUrlRequest: URLRequest(url: WebUri(url)),
    initialSettings: InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
    ),
    onWebViewCreated: (webControl) {
      initController(webControl);
    },
    onLoadStop: (controller, url) async {
      await controller.evaluateJavascript(
        source: """
          document.querySelectorAll('iframe').forEach(i => {
            i.style.pointerEvents = 'none';
            i.style.cursor = 'default';
          });
        """,
      );
    },
  );
  }

  Widget _buildSupported(BuildContext context) {
    return super.build(context);
  }

  Widget _buildNotSupported() {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Internal player currently not support for this platform'),
    );
  }

  void initController(InAppWebViewController webControl) {
    if (_videoController != null) return;
    _videoController = _VideoController(webControl);
  }

  void _onPlayPause() {
    if (_isPlaying) {
      _videoController?.pauseVideo();
    } else {
      _videoController?.playVideo();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }
}

class _VideoController {
  final InAppWebViewController controller;

  _VideoController(this.controller);

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
}
