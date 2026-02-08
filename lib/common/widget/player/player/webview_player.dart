import 'package:bingetube/common/widget/player/player/player.dart';

class WebviewPlayer implements Player {
  @override
  String get playerName => 'WebviewPlayer';
}

Player createPlayer() {
  return WebviewPlayer();
}
