import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:bingetube/common/widget/player/external_player_widget.dart';
import 'package:bingetube/common/widget/player/server/player_server.dart';

class InternalPlayerWidget extends ExternalPlayerWidget {
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
  ExternalPlayerState createState() => _InternalPlayerState();

  static get isSupportedPlatform {
    return Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isWindows;
  }
}

class _InternalPlayerState extends ExternalPlayerState {
  InAppWebViewController? _controller;

  @override
  void didUpdateWidget(covariant ExternalPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoId != widget.videoId) {
      final port = PlayerServer().port;
      final newUrl = 'http://localhost:$port?id=${widget.videoId}';
      _controller?.loadUrl(urlRequest: URLRequest(url: WebUri(newUrl)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (InternalPlayerWidget.isSupportedPlatform) {
      return _buildSupported(context);
    }
    return _buildNotSupported();
  }

  Widget _buildSupported(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget buildPlayerStack() {
    final url = 'http://localhost:${PlayerServer().port}?id=${widget.videoId}';
    return SizedBox(
      height: playerHeight,
      width: playerWidth,
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
        onWebViewCreated: (webControl) {
          _controller = webControl;
        },
      ),
    );
  }

  Widget _buildNotSupported() {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Internal player currently not support for this platform'),
    );
  }
}
