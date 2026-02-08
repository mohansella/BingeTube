import 'package:bingetube/common/widget/player/player/player.dart';
import 'package:flutter/widgets.dart';

class IframePlayer extends Player {
  IframePlayer({required super.listener});

  @override
  String get playerName => 'IframePlayer';

  @override
  void loadVideo(String videoId) {
    // TODO: implement loadVideo
  }

  @override
  Widget build(String videoId) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void startProgressTracking() {
    // TODO: implement startProgressTracking
  }
}

Player createPlayer(PlayerListener listener) {
  return IframePlayer(listener: listener);
}
