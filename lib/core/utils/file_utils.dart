import 'dart:typed_data';

import 'package:crypto/crypto.dart';

sealed class FileUtils {
  static String toSlugFileName(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  static String generateHash(Uint8List bytes, {int length = 8}) {
    final digest = sha1.convert(bytes);
    return digest.toString().substring(0, length);
  }
}
