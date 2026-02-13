import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

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

  static Future<File> writeToTempFile(String fileName, Uint8List data) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/$fileName');
    await tempFile.writeAsBytes(data);
    return tempFile;
  }
}
