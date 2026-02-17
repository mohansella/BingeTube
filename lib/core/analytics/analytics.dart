import 'dart:io';

import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart'
    show FlutterError, PlatformDispatcher, kReleaseMode;

sealed class Analytics {
  static final _logger = LogManager.getLogger('Analytics');

  static bool _isInited = false;
  static bool _isEnabled = false;

  static bool get isEnabled => _isEnabled;

  static Future<void> init() async {
    if (_isInited) return;

    if (!kReleaseMode) {
      _logger.info('Firebase analytics disabled in debug mode');
      _isInited = true;
      return;
    }

    final firebaseOptions = DefaultFirebaseOptions.currentPlatform;
    if (firebaseOptions.appId.isEmpty) {
      _logger.warning('Firebase analytics not configured!');
      _isInited = true;
      return;
    }

    _logger.info('initializing firebase analytics');
    await Firebase.initializeApp(options: firebaseOptions);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
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
