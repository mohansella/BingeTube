import 'package:bingetube/common/widget/player/player/player.dart';

class IframePlayer implements Player {
  @override
  String get playerName => 'IframePlayer';
}

Player createPlayer() {
  return IframePlayer();
}
