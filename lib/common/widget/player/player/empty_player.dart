import 'package:bingetube/common/widget/player/player/player.dart';
import 'package:flutter/widgets.dart';

class EmptyPlayer extends Player {
  EmptyPlayer({required super.listener});

  @override
  String get playerName => 'EmptyPlayer';

  @override
  void loadVideo(String videoId) {
    throw UnimplementedError();
  }

  @override
  Widget build(String videoId) {
    throw UnimplementedError();
  }

  @override
  void startProgressTracking() {
    throw UnimplementedError();
  }

  @override
  void seekTo(int pos) {
    throw UnimplementedError();
  }

  @override
  void play() {
    throw UnimplementedError();
  }

  @override
  void pause() {
    throw UnimplementedError();
  }
}

Player createPlayer(PlayerListener listener) {
  return EmptyPlayer(listener: listener);
}
