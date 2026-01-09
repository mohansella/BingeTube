import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

sealed class Analytics {
  static final _logger = LogManager.getLogger('Analytics');

  static bool _isInited = false;
  static bool _isEnabled = false;

  static bool get isEnabled => _isEnabled;

  static Future<void> init() async {
    if (_isInited) return;

    final firebaseOptions = DefaultFirebaseOptions.currentPlatform;
    if (firebaseOptions.appId.isEmpty) {
      _logger.info('Firebase analytics disabled');
      _isInited = true;
      return;
    }

    _logger.info('initializing firebase analytics');
    await Firebase.initializeApp(options: firebaseOptions);
    _isEnabled = true;
    _isInited = true;
  }

  static Future<void> logEvent(
    String name, {
    Map<String, Object>? parameters,
  }) async {
    if (!_isEnabled) return;
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
