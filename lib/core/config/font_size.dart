enum AppFontSize {
  small(0.85),
  medium(1.0),
  large(1.15);

  final double scale;

  const AppFontSize(this.scale);

  static String fromEnum(AppFontSize value) {
    return value.name;
  }

  static AppFontSize toEnum(String value) {
    return AppFontSize.values.byName(value);
  }
}
