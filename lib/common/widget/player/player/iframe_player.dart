import 'dart:js_interop_unsafe';
import 'dart:ui_web' as ui_web;
import 'dart:js_interop';

import 'package:bingetube/core/constants/assets.dart';
import 'package:web/web.dart' as web;

import 'package:bingetube/common/widget/player/player/player.dart';
import 'package:flutter/widgets.dart';

class IframePlayer extends Player {
  late final String _viewId;
  String? _videoId;
  web.HTMLIFrameElement? _iframeElement;

  String get url => './assets/${Assets.playerHtml.path}?id=$_videoId';

  IframePlayer({required super.listener}) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _viewId = 'iframe-player-$id';
    _registerView();
  }

  @override
  String get playerName => 'IframePlayer';

  @override
  void loadVideo(String videoId) {
    _videoId = videoId;
    if (_iframeElement?.src != url) {
      _iframeElement?.src = url;
    }
  }

  @override
  Widget build(String videoId) {
    _videoId = videoId;
    return HtmlElementView(viewType: _viewId);
  }

  void _registerView() {
    ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
      final element = web.HTMLIFrameElement()
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen';
      _iframeElement = element;

      if (_videoId != null) {
        element.src = url;
      }
      element.onLoad.listen(_onIFrameLoad);
      return element;
    });
  }

  @override
  void startProgressTracking() {
    final window = _iframeElement!.contentWindow as IframeWindow;
    window.startProgressTracking();
  }

  void _onIFrameLoad(web.Event event) {
    final window = _iframeElement!.contentWindow! as IframeWindow;
    final appBridge = (JSObject data) {
      final eventname = data.getProperty('eventname'.toJS) as JSString;
      final payloadObj = data.has('payload')
          ? data.getProperty('payload'.toJS) as JSAny
          : null;
      final payload = payloadObj?.toString();
      handleEvent(eventname.toString(), payload);
    }.toJS;
    window.appBridge = appBridge;
    if (window.isPlayerReady == true.toJS) {
      listener.onPlayerReady();
    }
  }

  @override
  void seekTo(int pos) {
    final window = _iframeElement!.contentWindow as IframeWindow;
    window.seekTo(pos.toJS);
  }

  @override
  void play() {
    final window = _iframeElement!.contentWindow as IframeWindow;
    window.playVideo();
  }

  @override
  void pause() {
    final window = _iframeElement!.contentWindow as IframeWindow;
    window.pauseVideo();
  }
}

Player createPlayer(PlayerListener listener) {
  return IframePlayer(listener: listener);
}

@JS()
extension type IframeWindow(JSObject _) implements JSObject {
  external void startProgressTracking();
  external void seekTo(JSNumber pos);
  external void playVideo();
  external void pauseVideo();
  external set appBridge(JSFunction fn);
  external JSBoolean? isPlayerReady;
}
