import 'dart:io';

import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/common/widget/player/server/player_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InternalPlayerWidget extends PlayerWidget {
  const InternalPlayerWidget({
    super.key,
    required super.videoId,
    required super.controller,
    required super.parentScroll,
    required super.childScroll,
    required super.onEvent,
    required super.slivers,
  }) : super.internal();

  @override
  ConsumerState<InternalPlayerWidget> createState() =>
      _InternalPlayerWidgetState();

  static get isSupportedPlatform {
    return Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isWindows;
  }
}

class _InternalPlayerWidgetState extends ConsumerState<InternalPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final url = 'http://localhost:${PlayerServer().port}?id=${widget.videoId}';
    if (InternalPlayerWidget.isSupportedPlatform) {
      return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: InAppWebView(initialUrlRequest: URLRequest(url: WebUri(url))),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Text('Internal player currently not support for this platform'),
    );
  }
}
