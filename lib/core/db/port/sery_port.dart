import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/file_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:archive/archive.dart';

sealed class SeryPort {
  static final _logger = LogManager.getLogger('SeryPort');

  static Future<String?> exportWithOSMenu(BingeModel model) async {
    final bytes = _buildJsonBytes(model);
    final filePath = await FilePicker.saveFile(
      dialogTitle: 'Select where to save your export:',
      fileName: buildFileName(model.title),
      bytes: bytes,
      type: .custom,
      allowedExtensions: ['binge'],
    );
    SeryPort._logger.info('exported at $filePath');
    return filePath;
  }

  static Future<File> exportToTempDirectory(int seryId) async {
    final model = await BingeDao(Database()).streamBingeModel(seryId).first;
    final bytes = _buildJsonBytes(model);
    final fileName = buildFileName(model.title, bytes: bytes);
    final file = FileUtils.writeToTempFile(fileName, bytes);
    return file;
  }

  static String buildFileName(
    String title, {
    Uint8List? bytes,
    bool withExtension = true,
  }) {
    final slugTitle = FileUtils.toSlugFileName(title);
    final jsonHash = bytes == null ? '' : '-${FileUtils.generateHash(bytes)}';
    final extension = withExtension ? '.binge' : '';
    final fileName = '$slugTitle$jsonHash$extension';
    return fileName;
  }

  static Uint8List _buildJsonBytes(BingeModel model) {
    final json = model.toJson();
    final videosJson = json['videos'] as List<Map<String, dynamic>>;
    final channelJsons = <String, dynamic>{};
    for (final videoJson in videosJson) {
      videoJson['video'].remove('createdAt');
      videoJson.remove('progressData'); //user's progress removed
      final channelJson = videoJson.remove('channel') as Map<String, dynamic>;
      final channelId = channelJson['channel']['id'] as String;
      if (!channelJsons.containsKey(channelId)) {
        channelJsons[channelId] = channelJson;
        channelJson['channel'].remove('createdAt');
      }
    }
    json['channels'] = channelJsons;
    final jsonString = jsonEncode(json);
    final rawBytes = utf8.encode(jsonString);
    final zipBytes = GZipEncoder().encode(rawBytes);
    return Uint8List.fromList(zipBytes);
  }

  static Future<Sery> import(
    Uint8List data, {
    required int collectionId,
    required int priority,
    int? seryId,
  }) async {
    final dataBytes = GZipDecoder().decodeBytes(data);
    final value = utf8.decode(dataBytes);
    final json = jsonDecode(value);
    return await _importAsJson(
      json,
      collectionId: collectionId,
      priority: priority,
      seryId: seryId,
    );
  }

  static Future<Sery> _importAsJson(
    dynamic json, {
    required int collectionId,
    required int priority,
    int? seryId,
  }) async {
    final videosJson = json['videos'] as List<dynamic>;
    final channelJsons = json['channels'];
    final createdAt = DateTime.now().millisecondsSinceEpoch;
    final progressData = <String, dynamic>{
      'updatedAt': createdAt,
      'watchPosition': 0,
      'isFinished': false,
    };
    for (final videoJson in videosJson) {
      final videoId = videoJson['video']['id'];
      videoJson['progressData'] = {...progressData, 'id': videoId};
      videoJson['video']['createdAt'] = createdAt;
      final channelId = videoJson['video']['channelId'] as String;
      final channelJson = channelJsons[channelId];
      channelJson['channel']['createdAt'] = createdAt;
      videoJson['channel'] = channelJson;
    }

    final model = BingeModel.fromJson(json);
    final db = Database();
    final videosDao = VideosDao(db);
    final bingeDao = BingeDao(db);
    final coverId = videosJson[0]['video']['id'];
    await videosDao.importVideoModels(model.videos);
    return await bingeDao.importBingeModel(
      model,
      collectionId: collectionId,
      coverId: coverId,
      priority: priority,
      seryId: seryId,
    );
  }
}
