import 'dart:convert';

import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:drift/drift.dart';
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

  static Future<Result<void>> validateKey(
    WidgetRef ref,
    String newApiKey,
  ) async {
    final jsonResult = await _getJsonResponse(
      ref,
      'ValidateApiKey',
      '$_channelsBaseUrl?key=$newApiKey&part=id&forHandle=@youtube',
    );
    return jsonResult.fold((jsonData) {
      if (jsonData['items'].isNotEmpty as bool) {
        return Success(Unit);
      }
      return Failure(Exception(jsonData['error']['message']));
    }, (err) => Failure(err));
  }

  static Future<Result<List<ChannelModel>>> searchChannels(
    WidgetRef ref,
    String query,
  ) async {
    final jsonResult = await _getJsonResponse(
      ref,
      'SearchChannels',
      '$_searchBaseUrl?key=API_KEY&part=snippet&type=channel&maxResults=50&q=${Uri.encodeQueryComponent(query)}',
    );
    if (jsonResult.isError()) {
      return Failure(jsonResult.exceptionOrNull()!);
    }
    final jsonData = jsonResult.getOrThrow();
    final items = jsonData['items'] as List;

    //0. build channelIds vs Etag
    Map<String, String> channelIdVsSEtag = {};
    List<String> channelIds = [];
    for (var item in items) {
      final channelId = item['id']['channelId'] as String;
      final etag = item['etag'] as String;
      channelIdVsSEtag[channelId] = etag;
      channelIds.add(channelId);
    }
    _logger.info('found ${channelIdVsSEtag.length} unique channel ids');

    final database = Database();
    final channelsDao = ChannelsDao(database);

    //1. find channelIds that needs update
    final channelsInDb = await channelsDao.getChannelsById(
      channelIdVsSEtag.keys.toList(),
    );
    final channelsInDbMap = Map.fromEntries(
      channelsInDb.map((c) => MapEntry(c.id, c)),
    );
    _logger.info('channels in db found: ${channelsInDbMap.length}');
    final cacheResetTime = DateTime.now().subtract(Duration(hours: 1));
    final channelsNeedUpdate = {...channelIdVsSEtag}
      ..removeWhere((id, setag) {
        if (!channelsInDbMap.containsKey(id)) {
          //no channel info in db
          return false;
        }
        final channel = channelsInDbMap[id];
        if (channel == null ||
            channel.setag != setag ||
            channel.updatedAt.millisecondsSinceEpoch <
                cacheResetTime.millisecondsSinceEpoch) {
          //no etag in db or new update found
          return false;
        }
        return true;
      });

    _logger.info('need to update ${channelsNeedUpdate.length} channels');
    if (channelsNeedUpdate.isNotEmpty) {
      await forceSyncChannelsWithSETag(ref, channelsNeedUpdate);
    }

    final channelModels = await channelsDao.getChannelModelByIds(channelIds);
    _logger.info('returning ${channelModels.length} models');
    return Success(channelModels);
  }

  static Future<Result<void>> forceSyncChannelsWithSETag(
    WidgetRef ref,
    Map<String, String> channelsVsSETag,
  ) async {
    final jsonResult = await _getJsonResponse(
      ref,
      'SyncChannels',
      '$_channelsBaseUrl?key=API_KEY&part=contentDetails,snippet,statistics,status&id=${channelsVsSETag.keys.join(",")}',
    );

    if (jsonResult.isError()) {
      return Failure(jsonResult.exceptionOrNull()!);
    }

    final jsonData = jsonResult.getOrThrow();
    final items = jsonData['items'] as List;

    final database = Database();
    final channelsDao = ChannelsDao(database);

    for (final item in items) {
      final updatedAt = Value(DateTime.now());
      final id = Value(item['id'] as String);

      //order: (channel, snippet, thumbnails, contentDetails, statistics, status)
      final channelComp = ChannelsCompanion(
        id: id,
        etag: Value(item['etag']),
        setag: Value(channelsVsSETag[id.value]),
        updatedAt: updatedAt,
      );

      final snippet = item['snippet'];
      final snippetComp = ChannelSnippetsCompanion(
        id: id,
        title: Value(snippet['title']),
        description: Value(snippet['description']),
        updatedAt: updatedAt,
      );

      final thubmnails = snippet['thumbnails'];
      final thumbnailsComp = ChannelThumbnailsCompanion(
        id: id,
        defaultUrl: Value(thubmnails['default']['url']),
        mediumUrl: Value(thubmnails['medium']['url']),
        highUrl: Value(thubmnails['high']['url']),
        updatedAt: updatedAt,
      );

      final playlists = item['contentDetails']['relatedPlaylists'];
      final likePlaylist = playlists['likes'];
      final uploadPlaylist = playlists['uploads'];
      final contentComp = ChannelContentDetailsCompanion(
        id: id,
        likesPlaylist: likePlaylist == null
            ? Value.absent()
            : Value(likePlaylist),
        uploadPlaylist: uploadPlaylist == null
            ? Value.absent()
            : Value(uploadPlaylist),
        updatedAt: const Value.absent(),
      );

      final statistics = item['statistics'];
      final statisticsComp = ChannelStatisticsCompanion(
        updatedAt: updatedAt,
        id: id,
        viewCount: Value(int.parse(statistics['viewCount'])),
        subscriberCount: Value(int.parse(statistics['subscriberCount'])),
        hiddenSubscriberCount: Value(statistics['hiddenSubscriberCount']),
        videoCount: Value(int.parse(statistics['videoCount'])),
      );

      final status = item['status'];
      final madeForKids = status['madeForKids'];
      final statusComp = ChannelStatusesCompanion(
        updatedAt: updatedAt,
        id: id,
        privacyStatus: Value(status['privacyStatus']),
        isLinked: Value(status['isLinked']),
        longUploadsStatus: Value(status['longUploadsStatus']),
        madeForKids: madeForKids == null ? Value.absent() : Value(madeForKids),
      );

      await channelsDao.insertChannelModel(
        channelComp,
        snippetComp,
        thumbnailsComp,
        contentComp,
        statisticsComp,
        statusComp,
      );
    }

    _logger.info('synchronized ${channelsVsSETag.length} channels to db');
    return Success(Unit);
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

  //Returns json only when status code is 200
  static Future<Result<dynamic>> _getJsonResponse(
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
      _updateApiKeyStatus(ref, response);
      if (response.statusCode != 200) {
        var errorMessage = _buildErrorMessage(response);
        return Failure(Exception(errorMessage));
      }
      final data = json.decode(response.body);
      return Success(data);
    } catch (e) {
      var message = e.toString();
      message = apiKey.length < 10
          ? message
          : message.replaceAll(apiKey, '*****');
      _logger.info('[$taskName] failed with error: $message');
      return Failure(Exception(message));
    }
  }

  static String _buildErrorMessage(Response response) {
    try {
      final data = json.decode(response.body);
      return data['error']['message'].toString();
    } catch (e) {
      return 'failed with code:${response.statusCode}';
    }
  }

  static void _updateApiKeyStatus(WidgetRef ref, Response response) {
    final meta = CoreUtils.readApiKeyMeta(ref);
    if (response.statusCode == 200 &&
        meta.status != .keyValid &&
        meta.status != .notConfigured) {
      _logger.info('changing key status from:${meta.status} to keyValid');
      return CoreUtils.writeApiKeyMeta(ref, meta.copyWith(status: .keyValid));
    } else if (response.statusCode != 200) {
      _logger.info('found error response during analyze: ${response.body}');
    }
    if (response.statusCode == 400 &&
        response.body.indexOf('API_KEY_INVALID') != 1) {
      _logger.info('changing key status from:${meta.status} to keyInvalid');
      return CoreUtils.writeApiKeyMeta(ref, meta.copyWith(status: .keyInvalid));
    }
  }
}
