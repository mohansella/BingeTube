import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

sealed class LogManager {
  static bool _isInitialized = false;

  static Logger getLogger(String name) {
    _init();
    return Logger(name);
  }

  static void _init() {
    if (_isInitialized) return;

    Logger.root.level = Level.FINE;

    Logger.root.onRecord.listen((record) {
      final error = record.error != null ? ' | ERROR: ${record.error}' : '';
      final stack = record.stackTrace != null
          ? '\nSTACKTRACE:\n${record.stackTrace}'
          : '';

      debugPrint(
        '[${record.level.name}] '
        '${record.time.toIso8601String()} '
        '${record.loggerName}: '
        '${record.message}'
        '$error'
        '$stack',
      );
    });

    _isInitialized = true;
  }
}
