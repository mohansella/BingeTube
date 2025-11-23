import 'package:bingetube/core/config/configuration.dart';
import 'package:timezone/data/latest.dart' as tz;

sealed class CoreInit {
  static bool _isInitialized = false;

  static initAll() async {
    if (_isInitialized) return;
    await ConfigStore.init();
    tz.initializeTimeZones();
    _isInitialized = true;
  }
}
