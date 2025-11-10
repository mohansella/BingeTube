import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Map<String, String> _cache = {};
  final StreamController<Future<void>> _streamController = StreamController();

  bool _initialized = false;

  SecureStorage._internal() {
    _streamController.stream.asyncMap((f) => f).listen((f) {});
  }

  static final SecureStorage _instance = SecureStorage._internal();

  static Future<void> init() async {
    if (_instance._initialized) {
      return;
    }
    var lcache = await _instance._storage.readAll();
    _instance._cache.addAll(lcache);
    _instance._initialized = true;
  }

  factory SecureStorage() => _instance;

  void set(String key, String val) {
    _cache[key] = val;
    _streamController.add(_storage.write(key: key, value: val));
  }

  String? get(String key) {
    return _cache[key];
  }

  void remove(String key) {
    _cache.remove(key);
  }
}
