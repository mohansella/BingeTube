import 'package:bingetube/core/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class Themes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  );
}

class ThemeModeController extends Notifier<ThemeMode> {
  @override
  build() {
    final value = SecureStorage().get(SecureStorageKey.themeMode);
    return _getThemeMode(value);
  }

  ThemeMode _getThemeMode(String? value) {
    if (value == null) {
      return ThemeMode.system;
    } else {
      return ThemeMode.values.byName(value);
    }
  }

  void setThemeMode(ThemeMode value) {
    SecureStorage().set(SecureStorageKey.themeMode, value.name);
    state = value;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);
