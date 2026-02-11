export 'empty_player.dart'
    if (dart.library.html) 'iframe_player.dart'
    if (dart.library.io) 'webview_player.dart';

import 'package:flutter/widgets.dart';

import 'empty_player.dart'
    if (dart.library.html) 'iframe_player.dart'
    if (dart.library.io) 'webview_player.dart'
    as platform;

abstract class Player {
  String get playerName;

  final PlayerListener listener;

  Widget build(String videoId);
  void loadVideo(String videoId);

  void startProgressTracking();
  void seekTo(int pos);

  Player({required this.listener});

  void handleEvent(String eventname, String? payload) {
    switch (eventname) {
      case 'onReady':
        return listener.onPlayerReady();
      case 'onStateChange':
        return listener.onPlayerStateChange(payload!);
      case 'onQualityChange':
        return listener.onPlayerQualityChange(payload!);
      case 'onRateChange':
        return listener.onPlayerRateChange(payload!);
      case 'onError':
        return listener.onPlayerError(payload!);
      case 'onProgress':
        return listener.onPlayerProgress(payload!);
    }
    throw Exception('Unknown eventname:$eventname with payload:$payload');
  }

  static Player create(PlayerListener listener) {
    return platform.createPlayer(listener);
  }
}

abstract class PlayerListener {
  void onPlayerReady();
  void onPlayerStateChange(String payload);
  void onPlayerQualityChange(String payload);
  void onPlayerRateChange(String payload);
  void onPlayerError(String payload);
  void onPlayerProgress(String payload);
}
