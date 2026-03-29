class Mutable<T> {
  T value;
  Mutable(this.value);

  @override
  String toString() => 'Mutable($value)';
}
