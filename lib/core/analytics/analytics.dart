import 'dart:io';

import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show FlutterError, PlatformDispatcher, kIsWeb;

sealed class Analytics {
  static final _logger = LogManager.getLogger('Analytics');

  static bool _isInited = false;
  static bool _isEnabled = false;

  static bool get isEnabled => _isEnabled;

  static Future<void> init() async {
    if (_isInited) return;

    final firebaseOptions = DefaultFirebaseOptions.currentPlatform;
    if (firebaseOptions.appId.isEmpty) {
      _logger.warning('Firebase analytics not configured!');
      _isInited = true;
      return;
    }

    _logger.info('initializing firebase analytics');
    await Firebase.initializeApp(options: firebaseOptions);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    if (kIsWeb) {
      _logger.info('crashlytics skipped on web build');
    } else if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }

    _logger.info('analytics initialized');
    _isEnabled = true;
    _isInited = true;
  }

  static String? _prevPageView;
  static Future<void> logPageView(String? name) async {
    if (!_isEnabled) return;
    if (name == null) return;
    if (_prevPageView == name) return;
    _prevPageView = name;
    _logger.info('navigating to $name');
    await FirebaseAnalytics.instance.logScreenView(screenName: name, screenClass: name);
  }

  static Future<void> logVideoWatched(String activeVideoId) async {
    await logEvent('watch_completed', parameters: {'videoId': activeVideoId});
  }

  static Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    if (!_isEnabled) return;
    _logger.info('event: $name');
    await FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }
}
