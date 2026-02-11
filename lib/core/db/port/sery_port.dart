import 'dart:convert';

import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:file_picker/file_picker.dart';

sealed class SeryPort {
  static final _logger = LogManager.getLogger('SeryPort');

  static Future<String?> export(BingeModel model) async {
    final fileName = 'export_${DateTime.now()}.binge';
    final json = model.toJson();
    final jsonString = jsonEncode(json);
    final filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Select where to save your export:',
      fileName: fileName,
      bytes: utf8.encode(jsonString),
      type: .custom,
      allowedExtensions: ['binge', 'json'],
    );
    SeryPort._logger.info('exported at $filePath');
    return filePath;
  }
}
