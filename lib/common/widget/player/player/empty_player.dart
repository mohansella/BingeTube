import 'package:bingetube/common/widget/player/player/player.dart';

class EmptyPlayer implements Player {
  @override
  String get playerName => 'EmptyPlayer';
}

Player createPlayer() {
  return EmptyPlayer();
}
