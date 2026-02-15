import 'package:bingetube/common/widget/player/player/player.dart';
import 'package:bingetube/common/widget/player/server/player_server.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewPlayer extends Player {
  static final _logger = LogManager.getLogger('WebviewPlayer');

  InAppWebViewController? _controller;

  WebviewPlayer({required super.listener});

  @override
  String get playerName => 'WebviewPlayer';

  @override
  Widget build(String videoId) {
    final url = 'http://localhost:${PlayerServer().port}?id=$videoId';
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        useShouldOverrideUrlLoading: true,
      ),
      onWebViewCreated: (webControl) {
        _initController(webControl);
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
            WebviewPlayer._logger.warning('Attempted navigation: $url');
            return NavigationActionPolicy.CANCEL;
          }
        }
        return NavigationActionPolicy.ALLOW;
      },
    );
  }

  void _initController(InAppWebViewController webController) {
    if (_controller != null) return;
    _controller = webController;
    _controller!.addJavaScriptHandler(
      handlerName: 'appBridge',
      callback: _callbackFromJS,
    );
  }

  dynamic _callbackFromJS(List<dynamic> args) {
    final data = args.first as Map;
    final eventname = data['eventname'] as String;
    final payload = data['payload'] as String?;
    handleEvent(eventname, payload);
  }

  @override
  void loadVideo(String videoId) {
    final port = PlayerServer().port;
    final newUrl = 'http://localhost:$port?id=$videoId';
    _controller!.loadUrl(urlRequest: URLRequest(url: WebUri(newUrl)));
  }

  @override
  void startProgressTracking() {
    _controller!.evaluateJavascript(source: 'startProgressTracking()');
  }

  @override
  void seekTo(int pos) {
    _controller!.evaluateJavascript(source: 'seekTo($pos)');
  }

  @override
  void play() {
    _controller!.evaluateJavascript(source: 'playVideo()');
  }

  @override
  void pause() {
    _controller!.evaluateJavascript(source: 'pauseVideo()');
  }
}

Player createPlayer(PlayerListener listener) {
  return WebviewPlayer(listener: listener);
}
