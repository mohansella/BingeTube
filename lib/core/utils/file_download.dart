import 'dart:typed_data';

import 'file_download_io.dart'
    if (dart.library.js_interop) 'file_download_web.dart'
    as platform;

Future<String?> saveFile({
  required String dialogTitle,
  required String fileBaseName,
  required String fileName,
  required String extension,
  required Uint8List bytes,
  required String mimeType,
}) {
  return platform.saveFile(
    dialogTitle: dialogTitle,
    fileBaseName: fileBaseName,
    fileName: fileName,
    extension: extension,
    bytes: bytes,
    mimeType: mimeType,
  );
}
