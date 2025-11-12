import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureStorageKey { apikey }

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Map<String, String> _cache = {};
  final StreamController<Future<void>> _streamController = StreamController();

  bool _initialized = false;

  SecureStorage._internal() {
    _streamController.stream.asyncMap((f) => f).listen((f) {
      print('test');
    });
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

  void set(SecureStorageKey key, String val) {
    _cache[key.name] = val;
    _streamController.add(_storage.write(key: key.name, value: val));
  }

  String? get(SecureStorageKey key) {
    return _cache[key.name];
  }

  void remove(SecureStorageKey key) {
    _cache.remove(key.name);
    _streamController.add(_storage.delete(key: key.name));
  }
}
