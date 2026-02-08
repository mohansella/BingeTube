import 'dart:ui_web' as ui_web;

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
      return element;
    });
  }

  @override
  void startProgressTracking() {
    // TODO: implement startProgressTracking
  }
}

Player createPlayer(PlayerListener listener) {
  return IframePlayer(listener: listener);
}
