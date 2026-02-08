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

  Player({required this.listener});

  static Player create(PlayerListener listener) {
    return platform.createPlayer(listener);
  }
}

abstract class PlayerListener {
  void onPlayerReady();
  void onPlayerStateChange(payload);
  void onPlayerQualityChange(payload);
  void onPlayerRateChange(payload);
  void onPlayerError(payload);
  void onPlayerProgress(payload);
}
