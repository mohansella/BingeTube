extension ListChunkExtension<T> on List<T> {
  Iterable<List<T>> chunked(int size) sync* {
    for (var i = 0; i < length; i += size) {
      yield sublist(i, i + size > length ? length : i + size);
    }
  }
}
