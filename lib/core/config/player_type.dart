enum PlayerType {
  external,
  internal;

  static String fromEnum(PlayerType value) {
    return value.name;
  }

  static PlayerType toEnum(String value) {
    return PlayerType.values.byName(value);
  }
}
