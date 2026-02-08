export 'empty_player.dart'
    if (dart.library.html) 'iframe_player.dart'
    if (dart.library.io) 'webview_player.dart';

import 'empty_player.dart'
    if (dart.library.html) 'iframe_player.dart'
    if (dart.library.io) 'webview_player.dart' as platform;

abstract class Player {
  String get playerName;

  static Player create() {
    return platform.createPlayer();
  }
}
