import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:timezone/data/latest.dart' as tz;

sealed class CoreInit {
  static bool _isInitialized = false;

  static initAll() async {
    if (_isInitialized) return;

    //initialize secure storage
    await ConfigStore.init();

    //initialize timezone data
    tz.initializeTimeZones();

    //initialize sqlite3 with drift
    var db = Database();
    await db.customSelect('SELECT 1').get();

    _isInitialized = true;
  }
}
