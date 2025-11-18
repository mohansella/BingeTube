import 'package:flutter/material.dart';

sealed class ConfigSerializer {
  static String serializeThemeMode(ThemeMode value) {
    return value.name;
  }

  static ThemeMode deserializeTheMode(String value) {
    return ThemeMode.values.byName(value);
  }

}
