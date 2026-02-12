import 'dart:convert';

import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/file_utils.dart';
import 'package:file_picker/file_picker.dart';

sealed class SeryPort {
  static final _logger = LogManager.getLogger('SeryPort');

  static Future<String?> export(BingeModel model) async {
    final slugTitle = FileUtils.toSlugFileName(model.title);
    final json = model.toJson();
    final jsonString = jsonEncode(json);
    final bytes = utf8.encode(jsonString);
    final jsonHash = FileUtils.generateHash(bytes);
    final fileName = '$slugTitle-$jsonHash';
    final filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Select where to save your export:',
      fileName: fileName,
      bytes: bytes,
      type: .custom,
      allowedExtensions: ['binge'],
    );
    SeryPort._logger.info('exported at $filePath');
    return filePath;
  }
}
