import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:timezone/data/latest.dart' as tz;

sealed class CoreInit {
  static bool _isInitialized = false;

  static Future<void> initAll() async {
    if (_isInitialized) return;

    await Analytics.init();

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
