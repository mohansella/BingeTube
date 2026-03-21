import 'package:bingetube/common/widget/player/server/player_server.dart';
import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/constants/app_env.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:timezone/data/latest.dart' as tz;

sealed class CoreInit {
  static bool _isInitialized = false;
  static final _logger = LogManager.getLogger('CoreInit');

  static Future<void> initAll() async {
    if (_isInitialized) return;

    _logger.info('app_env: ${AppEnv.instance}');

    await Analytics.init();

    //initialize secure storage
    await ConfigStore.init();

    //initialize timezone data
    tz.initializeTimeZones();

    //initialize sqlite3 with drift
    var db = Database();
    await db.customSelect('SELECT 1').get();

    //initialize localserver
    await PlayerServer().start();

    _isInitialized = true;
  }
}
