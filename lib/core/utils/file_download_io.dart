import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

Future<String?> saveFile({
  required String dialogTitle,
  required String fileBaseName,
  required String fileName,
  required String extension,
  required Uint8List bytes,
  required String mimeType,
}) async {
  final selectedPath = await FilePicker.saveFile(
    dialogTitle: dialogTitle,
    fileName: fileBaseName,
    type: .custom,
    allowedExtensions: [extension],
  );
  if (selectedPath == null) {
    return null;
  }

  final file = File(_withSingleExtension(selectedPath, extension));
  await file.parent.create(recursive: true);
  await file.writeAsBytes(bytes);
  return file.path;
}

String _withSingleExtension(String filePath, String extension) {
  final suffix = '.$extension';
  var normalized = filePath;
  while (normalized.toLowerCase().endsWith('$suffix$suffix'.toLowerCase())) {
    normalized = normalized.substring(0, normalized.length - suffix.length);
  }
  if (normalized.toLowerCase().endsWith(suffix.toLowerCase())) {
    return normalized;
  }
  return p.setExtension(normalized, suffix);
}
