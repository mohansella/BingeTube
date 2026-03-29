import 'dart:convert';

import 'package:bingetube/core/constants/app_env.dart';
import 'package:bingetube/core/http/http_client.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:drift/drift.dart';
import 'package:result_dart/result_dart.dart';

class BingeApi {
  static final _logger = LogManager.getLogger('BingeApi');

  static Future<Result<dynamic>> getDiscoverData() {
    return _getJsonResponse(
      'DiscoverJSON',
      '${AppEnv.instance.baseUrl}/discover/discover.json',
    );
  }

  static Future<Result<Uint8List>> getBingeBlob(String path) {
    return _getBlobResponse('BingeFile', '${AppEnv.instance.baseUrl}/discover/$path');
  }

  static Future<Result<dynamic>> _getJsonResponse(String taskName, String uri) async {
    _logger.info('[$taskName] initiating http request');
    try {
      final url = Uri.parse(uri);
      final response = await CoreClient.get(url);
      _logger.info('[$taskName] succeeded with status: ${response.statusCode}');
      if (response.statusCode != 200) {
        return Failure(Exception(response.reasonPhrase));
      }
      final data = json.decode(response.body);
      return Success(data);
    } catch (e) {
      var message = e.toString();
      _logger.info('[$taskName] failed with error: $message');
      return Failure(Exception(message));
    }
  }

  static Future<Result<Uint8List>> _getBlobResponse(String taskName, String uri) async {
    _logger.info('[$taskName] initiating http request');
    try {
      final url = Uri.parse(uri);
      final response = await CoreClient.get(url);
      _logger.info('[$taskName] complete with status: ${response.statusCode}');
      if (response.statusCode != 200) {
        _logger.warning('[$taskName] failed for uri:$uri');
        return Failure(Exception(response.reasonPhrase));
      }
      return Success(response.bodyBytes);
    } catch (e) {
      var message = e.toString();
      _logger.info('[$taskName] failed with error: $message');
      return Failure(Exception(message));
    }
  }
}
