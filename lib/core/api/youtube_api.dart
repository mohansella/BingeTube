import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bingetube/core/config/apikey_util.dart';
import 'package:bingetube/core/http/http_client.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/core_utils.dart';
import 'package:bingetube/core/api/youtube_data.dart';
import 'package:result_dart/result_dart.dart';

const _channelsBaseUrl = 'https://www.googleapis.com/youtube/v3/channels';
const _searchBaseUrl = 'https://www.googleapis.com/youtube/v3/search';

class YoutubeApi {
  static final Logger _logger = LogManager.getLogger('YoutubeApi');

  static Future<Result<void>> validateYouTubeApiKey(
    WidgetRef ref,
    String newApiKey,
  ) async {
    final result = await _getResponse(
      ref,
      'ValidateApiKey',
      '$_channelsBaseUrl?key=$newApiKey&part=id&forHandle=@youtube',
    );
    return result.fold((res) {
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['items'].isNotEmpty as bool) {
          return Success(Void);
        }
      }
      return Failure(Exception(data['error']['message']));
    }, (err) => Failure(err));
  }

  static searchChannel(WidgetRef ref, String query) async {
    await _getResponse(
      ref,
      'SearchChannels',
      '$_searchBaseUrl?key=API_KEY&part=snippet&type=channel&maxResults=50&q=${Uri.encodeQueryComponent(query)}',
    );
  }

  static Future<List<YouTubeChannel>?> searchChannelsOld(
    WidgetRef ref,
    String apiKey,
    String query,
  ) async {
    final url = Uri.parse(
      '$_searchBaseUrl'
      '?part=snippet'
      '&q=${Uri.encodeQueryComponent(query)}'
      '&type=channel'
      '&maxResults=50'
      '&key=$apiKey',
    );

    final response = await CoreClient.get(url);

    if (response.statusCode == 200) {
      ApiKeyUtil.addQuota(ref, .searchChannel, 100);
      final data = json.decode(response.body);
      final items = (data['items'] as List?) ?? [];
      return items.map((item) => YouTubeChannel.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<List<YouTubeVideo>?> searchVideos(
    WidgetRef ref,
    String apiKey,
    String query,
  ) async {
    final url = Uri.parse(
      '$_searchBaseUrl'
      '?part=snippet'
      '&q=${Uri.encodeQueryComponent(query)}'
      '&type=video'
      '&maxResults=50'
      '&key=$apiKey',
    );

    final response = await CoreClient.get(url);

    if (response.statusCode == 200) {
      ApiKeyUtil.addQuota(ref, .searchVideo, 100);
      final data = json.decode(response.body);
      final items = (data['items'] as List?) ?? [];
      return items
          .where((item) {
            return item['id']['kind'] == 'youtube#video';
          })
          .map((item) => YouTubeVideo.fromJson(item))
          .toList();
    } else {
      return null;
    }
  }

  static Future<Result<Response>> _getResponse(
    WidgetRef ref,
    String taskName,
    String uri,
  ) async {
    _logger.info('[$taskName] initiating http request');
    final apiKey = CoreUtils.readApiKey(ref);
    try {
      final url = Uri.parse(
        uri.replaceAll(
          'key=API_KEY',
          'key=${Uri.encodeQueryComponent(apiKey)}',
        ),
      );
      final response = await CoreClient.get(url);
      _logger.info('[$taskName] succeeded with status: ${response.statusCode}');
      _analyzeResponse(ref, response);
      return response.toSuccess();
    } catch (e) {
      var message = e.toString();
      message = apiKey.length < 10
          ? message
          : message.replaceAll(apiKey, '*****');
      _logger.info('[$taskName] failed with error: $message');
      return Failure(Exception(message));
    }
  }

  static void _analyzeResponse(WidgetRef ref, Response response) {
    final meta = CoreUtils.readApiKeyMeta(ref);
    final responseString = response.toString();
    if (response.statusCode == 200 && meta.status != .keyValid) {
      _logger.info('changing key status from:${meta.status} to keyValid');
      return CoreUtils.writeApiKeyMeta(ref, meta.copyWith(status: .keyValid));
    } else {
      _logger.info('found error response during analyze: $responseString');
    }
    if (response.statusCode == 400 &&
        response.body.indexOf('API_KEY_INVALID') != 1) {
      _logger.info('changing key status from:${meta.status} to keyInvalid');
      return CoreUtils.writeApiKeyMeta(ref, meta.copyWith(status: .keyInvalid));
    }
  }
}
