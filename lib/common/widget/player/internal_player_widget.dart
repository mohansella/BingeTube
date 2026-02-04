import 'dart:io';

import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/common/widget/player/server/player_server.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
}

class _InternalPlayerWidgetState extends ConsumerState<InternalPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final url = 'http://localhost:${PlayerServer().port}?id=${widget.videoId}';
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    if (Platform.isAndroid || Platform.isMacOS || Platform.isIOS) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flutter Simple Example')),
        body: WebViewWidget(controller: controller),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Text('internal player currently not support for this platform'),
    );
  }
}
