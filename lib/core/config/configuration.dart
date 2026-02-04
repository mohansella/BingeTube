import 'dart:async';

import 'package:bingetube/core/config/apikey_meta.dart';
import 'package:bingetube/core/config/font_size.dart';
import 'package:bingetube/core/config/player_type.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

enum ConfigKey<T> {
  themeMode<ThemeMode>(
    ThemeMode.dark,
    ConfigSerializer.fromThemeMode,
    ConfigSerializer.toThemeMode,
  ),

  apiKeyMeta<ApiKeyMeta>(
    ApiKeyMeta(),
    ApiKeyMeta.toJsonString,
    ApiKeyMeta.fromJsonString,
  ),

  appFontSize<AppFontSize>(
    AppFontSize.medium,
    AppFontSize.fromEnum,
    AppFontSize.toEnum,
  ),

  playerType<PlayerType>(
    PlayerType.external,
    PlayerType.fromEnum,
    PlayerType.toEnum,
  );

  final T defaultValue;
  final String Function(T) serializer;
  final T Function(String) deserializer;

  static String noOp(s) => s;

  const ConfigKey(this.defaultValue, this.serializer, this.deserializer);
}

sealed class ConfigProviders {
  static final theme = NotifierProvider(
    () => ConfigController<ThemeMode>(ConfigKey.themeMode),
  );

  static final apiKeyMeta = NotifierProvider(
    () => ConfigController<ApiKeyMeta>(ConfigKey.apiKeyMeta),
  );

  static final appFontSize = NotifierProvider(
    () => ConfigController<AppFontSize>(ConfigKey.appFontSize),
  );

  static final playerType = NotifierProvider(
    () => ConfigController<PlayerType>(ConfigKey.playerType),
  );
}

class ConfigController<T> extends Notifier<T> {
  final ConfigKey<T> _key;

  ConfigController(this._key);

  @override
  T build() {
    return ConfigStore().get(_key);
  }

  void save(T value) {
    ConfigStore().set(_key, value);
    state = value;
  }

  void remove() {
    ConfigStore().remove(_key);
    state = _key.defaultValue;
  }
}

class ConfigStore {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Map<String, String> _cache = {};
  final StreamController<Future<void>> _streamController = StreamController();

  bool _initialized = false;

  ConfigStore._internal() {
    _streamController.stream.asyncMap((f) => f).listen((f) {});
  }

  static final ConfigStore _instance = ConfigStore._internal();
  static final _logger = LogManager.getLogger('ConfigStore');

  static Future<void> init() async {
    if (_instance._initialized) {
      return;
    }
    var lcache = await _instance._storage.readAll();
    _instance._cache.addAll(lcache);
    _instance._initialized = true;
    _logger.info('loaded ConfigStore : ${lcache.keys}');
  }

  factory ConfigStore() {
    if (!_instance._initialized) {
      throw 'SecureStorage factory should not be accessed before initialization';
    }
    return _instance;
  }

  void set<T>(ConfigKey<T> key, T val) {
    String serialValue = key.serializer(val);
    _cache[key.name] = serialValue;
    _streamController.add(_storage.write(key: key.name, value: serialValue));
  }

  T get<T>(ConfigKey<T> key) {
    final serialValue = _cache[key.name];
    if (serialValue == null) {
      return key.defaultValue;
    } else {
      return key.deserializer(serialValue);
    }
  }

  void remove<T>(ConfigKey<T> key) {
    _cache.remove(key.name);
    _streamController.add(_storage.delete(key: key.name));
  }
}

sealed class ConfigSerializer {
  static String fromThemeMode(ThemeMode value) {
    return value.name;
  }

  static ThemeMode toThemeMode(String value) {
    return ThemeMode.values.byName(value);
  }
}
