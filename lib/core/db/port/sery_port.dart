import 'dart:convert';
import 'dart:typed_data';

import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/file_utils.dart';
import 'package:file_picker/file_picker.dart';

sealed class SeryPort {
  static final _logger = LogManager.getLogger('SeryPort');

  static Future<String?> export(BingeModel model) async {
    final slugTitle = FileUtils.toSlugFileName(model.title);
    final bytes = _getModelJsonBytes(model);
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

  static Uint8List _getModelJsonBytes(BingeModel model) {
    final json = model.toJson();
    final videosJson = json['videos'] as List<Map<String, dynamic>>;
    final channelJsons = <String, dynamic>{};
    for (final videoJson in videosJson) {
      for (Map<String, dynamic> dataObj in videoJson.values) {
        dataObj.remove('createdAt');
      }
      videoJson.remove('progressData'); //user's progress removed
      final channelJson = videoJson.remove('channel') as Map<String, dynamic>;
      final channelId = channelJson['channel']['id'] as String;
      if (!channelJsons.containsKey(channelId)) {
        channelJsons[channelId] = channelJson;
      }
    }
    json['channels'] = channelJsons;
    final jsonString = jsonEncode(json);
    return utf8.encode(jsonString);
  }
}
