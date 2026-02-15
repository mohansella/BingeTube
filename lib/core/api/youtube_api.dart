import 'dart:convert';

import 'package:bingetube/core/db/access/playlists.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bingetube/core/constants/constants.dart';
import 'package:bingetube/core/config/apikey_util.dart';
import 'package:bingetube/core/http/http_client.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/core_utils.dart';

import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/access/search.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';

const _searchBaseUrl = 'https://www.googleapis.com/youtube/v3/search';
const _channelsBaseUrl = 'https://www.googleapis.com/youtube/v3/channels';
const _videosBaseUrl = 'https://www.googleapis.com/youtube/v3/videos';
const _playlistBaseUrl = 'https://www.googleapis.com/youtube/v3/playlists';
const _playlistItemsBaseurl =
    'https://www.googleapis.com/youtube/v3/playlistItems';

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

  static Future<Result<ChannelSearchModel>> searchChannels(
    WidgetRef ref,
    String query,
  ) async {
    final database = Database();
    final searchDao = SearchDao(database);
    final channelSearchSize = PageSizeConstants.channelEntriesInSearchPage;
    final nowTime = DateTime.now();

    final searchModel = await searchDao.getChannelSearchModel(query);
    if (searchModel != null) {
      final searchMeta = searchModel.meta;
      final expiresAt = searchMeta.updatedAt.add(
        CacheConstants.syncChannelSearchResultAfter,
      );
      _logger.info(
        'found ${searchModel.channels.length} results in db for query: $query'
        ' with updatedAt: ${searchMeta.updatedAt} and expiresAt : $expiresAt',
      );
      if (expiresAt.isBefore(nowTime)) {
        _logger.info('cache expired');
      } else {
        return Success(searchModel);
      }
    }

    final jsonResult = await _getJsonResponse(
      ref,
      'SearchChannels',
      '$_searchBaseUrl?key=API_KEY&part=snippet&type=channel&maxResults=$channelSearchSize&q=${Uri.encodeQueryComponent(query)}',
    );
    if (jsonResult.isError()) {
      return Failure(jsonResult.exceptionOrNull()!);
    } else {
      ApiKeyUtil.addQuota(ref, .searchChannel, 100);
    }
    final jsonData = jsonResult.getOrThrow();
    final items = jsonData['items'] as List;

    //0. build channelIds vs SEtag
    Map<String, String> channelIdVsSEtag = {};
    List<String> channelIds = [];
    for (var item in items) {
      final kind = item['id']['kind'];
      if (kind != 'youtube#channel') {
        _logger.warning('skipping kind in channel search result: $kind');
        continue;
      }
      final channelId = item['id']['channelId'] as String;
      final setag = item['etag'] as String;
      channelIdVsSEtag[channelId] = setag;
      channelIds.add(channelId);
    }
    _logger.info('found ${channelIdVsSEtag.length} unique channel ids');

    final channelsDao = ChannelsDao(database);

    //1. find channelIds that needs update
    final channelsInDb = await channelsDao.getChannelsById(
      channelIdVsSEtag.keys.toList(),
    );
    final channelsInDbMap = Map.fromEntries(
      channelsInDb.map((c) => MapEntry(c.id, c)),
    );
    _logger.info('channels in db found: ${channelsInDbMap.length}');
    final channelsNeedUpdate = {...channelIdVsSEtag}
      ..removeWhere((id, setag) {
        if (!channelsInDbMap.containsKey(id)) {
          //no channel info in db
          return false;
        }
        final channel = channelsInDbMap[id];
        final expiresAt = channel?.updatedAt.add(
          CacheConstants.syncChannelAfter,
        );
        if (channel == null ||
            channel.setag != setag ||
            expiresAt!.isBefore(nowTime)) {
          //no setag in db or new update found or cache invalid
          return false;
        }
        return true;
      });

    _logger.info('need to update ${channelsNeedUpdate.length} channels');
    if (channelsNeedUpdate.isNotEmpty) {
      final syncResult = await _forceSyncChannelsWithSETag(
        ref,
        channelsNeedUpdate,
      );
      if (syncResult.isError()) {
        return Failure(syncResult.exceptionOrNull()!);
      }
    }
    searchDao.insertChannelSearch(query, channelIds);

    var model = await searchDao.getChannelSearchModel(query);
    _logger.info('returning ${model?.channels.length} models');
    if (model == null) {
      final now = DateTime.now();
      model = ChannelSearchModel(
        ChannelSearche(createdAt: now, updatedAt: now, id: 0, query: query),
        [],
      );
    }
    return Success(model);
  }

  static Future<Result<VideoSearchModel>> searchVideos(
    WidgetRef ref,
    String query,
  ) async {
    final database = Database();
    final searchDao = SearchDao(database);
    final videoSearchSize = PageSizeConstants.videoEntriesInSearchPage;
    final nowTime = DateTime.now();

    final searchModel = await searchDao.getVideoSearchModel(query);
    if (searchModel != null) {
      final videoSearch = searchModel.meta;
      final expiresAt = videoSearch.updatedAt.add(
        CacheConstants.syncVideosSearchResultAfter,
      );
      _logger.info(
        'found ${searchModel.videos.length} results in db for query: $query'
        ' with updatedAt: ${videoSearch.updatedAt} and expiresAt : $expiresAt',
      );
      if (expiresAt.isBefore(nowTime)) {
        _logger.info('cache expired');
      } else {
        return Success(searchModel);
      }
    }

    final jsonResult = await _getJsonResponse(
      ref,
      'SearchChannels',
      '$_searchBaseUrl?key=API_KEY&part=snippet&type=video&maxResults=$videoSearchSize&q=${Uri.encodeQueryComponent(query)}',
    );

    if (jsonResult.isError()) {
      return Failure(jsonResult.exceptionOrNull()!);
    } else {
      ApiKeyUtil.addQuota(ref, .searchVideo, 100);
    }
    final jsonData = jsonResult.getOrThrow();
    final items = jsonData['items'] as List;

    //0. build videoIds vs SEtag
    Map<String, String> videoIdVsSETag = {};
    Set<String> channelIds = {};
    List<String> videoIds = [];
    for (var item in items) {
      final kind = item['id']['kind'];
      if (kind != 'youtube#video') {
        _logger.warning('skipping unknown kind in video search result: $kind');
        continue;
      }
      final videoId = item['id']['videoId'];
      final channelId = item['snippet']['channelId'];
      final setag = item['etag'] as String;
      videoIdVsSETag[videoId] = setag;
      videoIds.add(videoId);
      channelIds.add(channelId);
    }
    _logger.info(
      'found ${videoIdVsSETag.length} videos ids with ${channelIds.length} unique channels',
    );

    //1. find channelIds that needs update
    final channelDao = ChannelsDao(database);
    final channels = await channelDao.getChannelsById(channelIds.toList());
    _logger.info('found ${channels.length} channels found in db');
    final channelIdsToSync = {...channelIds};
    for (var channel in channels) {
      final expiresAt = channel.updatedAt.add(
        CacheConstants.syncChannelSearchResultAfter,
      );
      if (nowTime.isAfter(expiresAt) && channel.etag != null) {
        channelIdsToSync.remove(channel.id);
      }
    }
    _logger.info('need to sync ${channelIdsToSync.length} channels');
    if (channelIdsToSync.isNotEmpty) {
      final syncResult = await _forceSyncChannels(ref, channelIdsToSync);
      if (syncResult.isError()) {
        return Failure(syncResult.exceptionOrNull()!);
      }
    }

    //2. find videoIds that needs update
    final videosDao = VideosDao(database);
    final videosInDb = await videosDao.getVideosById(
      videoIdVsSETag.keys.toSet(),
    );
    final videosInDbMap = Map.fromEntries(
      videosInDb.map((v) => MapEntry(v.id, v)),
    );
    _logger.info('videos in db found: ${videosInDbMap.length}');
    final videosNeedUpdate = {...videoIdVsSETag}
      ..removeWhere((id, setag) {
        if (!videosInDbMap.containsKey(id)) {
          //no video info in db
          return false;
        }
        final video = videosInDbMap[id];
        final expiresAt = video?.updatedAt.add(CacheConstants.syncVideosAfter);
        if (video == null ||
            video.setag != setag ||
            expiresAt!.isBefore(nowTime)) {
          //no etag in db or new upate found or cache invalid
          return false;
        }
        return true;
      });

    _logger.info('need to update ${videosNeedUpdate.length} videos');
    if (videosNeedUpdate.isNotEmpty) {
      final syncResult = await _forceSyncVideosWithSETag(ref, videosNeedUpdate);
      if (syncResult.isError()) {
        return Failure(syncResult.exceptionOrNull()!);
      }
    }
    searchDao.insertVideoSearch(query, videoIds);

    var model = await searchDao.getVideoSearchModel(query);
    _logger.info('returning ${model?.videos.length} models');
    if (model == null) {
      final now = DateTime.now();
      model = VideoSearchModel(
        VideoSearche(createdAt: now, updatedAt: now, id: 0, query: query),
        [],
      );
    }
    return Success(model);
  }

  static Future<Result<void>> syncPlaylist(
    WidgetRef ref,
    String channelId,
    bool Function(int, int) updateProgress,
  ) async {
    Result<PlaylistModels> failure = Failure(Exception());
    final channelDao = ChannelsDao(Database());
    final playlistDao = PlaylistsDao(Database());

    dynamic uploadItem;
    dynamic likeItem;
    final channel = await channelDao.getChannelModelById(channelId);
    final uploadId = channel.contentDetails.uploadPlaylist;
    if (uploadId != null) {
      if (!updateProgress(0, 3)) return failure;
      final jsonResult = await _getJsonResponse(
        ref,
        'FetchUploadPlaylist',
        '$_playlistBaseUrl?key=API_KEY&part=contentDetails,snippet&id=$uploadId',
      );

      if (jsonResult.isError()) {
        return Failure(jsonResult.exceptionOrNull()!);
      } else {
        ApiKeyUtil.addQuota(ref, .fetchPlaylist, 1);
      }
      final jsonData = jsonResult.getOrThrow();
      final items = jsonData['items'] as List;
      uploadItem = items[0];
    }

    final likesId = channel.contentDetails.likesPlaylist;
    if (likesId != null && likesId.isNotEmpty) {
      if (!updateProgress(1, 3)) return failure;
      final jsonResult = await _getJsonResponse(
        ref,
        'FetchLikesPlaylist',
        '$_playlistBaseUrl?key=API_KEY&part=contentDetails,snippet&id=$likesId',
      );

      if (jsonResult.isError()) {
        return Failure(jsonResult.exceptionOrNull()!);
      } else {
        ApiKeyUtil.addQuota(ref, .fetchPlaylist, 1);
      }
      final jsonData = jsonResult.getOrThrow();
      final items = jsonData['items'] as List;
      likeItem = items[0];
    }
    if (!updateProgress(2, 3)) return failure;

    var isNextPageAvailable = true;
    String nextPageToken = '';
    List<dynamic> normalItems = [];
    while (isNextPageAvailable) {
      final jsonResult = await _getJsonResponse(
        ref,
        'FetchNormalPlaylist',
        '$_playlistBaseUrl?key=API_KEY&part=contentDetails,snippet'
            '&channelId=$channelId&pageToken=$nextPageToken&maxResults=50',
      );

      if (jsonResult.isError()) {
        return Failure(jsonResult.exceptionOrNull()!);
      } else {
        ApiKeyUtil.addQuota(ref, .fetchPlaylist, 1);
      }
      final jsonData = jsonResult.getOrThrow();
      final items = jsonData['items'] as List;
      normalItems.addAll(items);
      _logger.info('found:${items.length} total:${normalItems.length}');

      final totalResults = jsonData['pageInfo']['totalResults'];
      if (!updateProgress(normalItems.length, totalResults)) return failure;

      nextPageToken = jsonData['nextPageToken'] ?? '';
      isNextPageAvailable = nextPageToken.isNotEmpty;
    }
    _logger.info('found normalItems:${normalItems.length}');

    await playlistDao.upsertAllPlaylistItems(
      normalItems,
      uploadItem: uploadItem,
      likeItem: likeItem,
    );

    return Success(Unit);
  }

  static Future<Result<void>> syncPlaylistVideos(
    WidgetRef ref,
    String playlistId,
    bool Function(bool, int, int) updateProgress,
  ) async {
    Result<void> failure = Failure(Exception());
    final playlistDao = PlaylistsDao(Database());
    if (!updateProgress(false, 0, 1)) return failure;

    final lastUpdateTime = await playlistDao.getPlaylistItemsUpdateTime(
      playlistId,
    );
    final isAfter = DateTime.now().subtract(
      CacheConstants.syncPlaylistItemsAfter,
    );
    _logger.info('lastUpdateTime:$lastUpdateTime isAfter:$isAfter');
    if (lastUpdateTime == null) {
      _logger.info('no entries found in db for playlist:$playlistId');
    } else if (lastUpdateTime.isAfter(isAfter)) {
      _logger.info('cache entries valid for playlist:$playlistId');
      return Success(Unit);
    }

    var isNextPageAvailable = true;
    String nextPageToken = '';
    List<String> videoIds = [];
    while (isNextPageAvailable) {
      final jsonResult = await _getJsonResponse(
        ref,
        'SyncPlaylistVideos',
        '$_playlistItemsBaseurl?key=API_KEY&part=snippet&maxResults=50'
            '&playlistId=$playlistId&pageToken=$nextPageToken',
      );
      if (jsonResult.isError()) {
        return Failure(jsonResult.exceptionOrNull()!);
      } else {
        ApiKeyUtil.addQuota(ref, .fetchPlaylistItems, 1);
      }

      final jsonData = jsonResult.getOrThrow();
      final items = jsonData['items'] as List;
      for (final item in items) {
        final resourceId = item['snippet']['resourceId'];
        final kind = resourceId['kind'];
        if (kind != 'youtube#video') {
          _logger.warning(
            'unexpected kind found in playlist:$playlistId with resourceId:$resourceId',
          );
          continue;
        }
        videoIds.add(resourceId['videoId']);
      }

      final total = jsonData['pageInfo']['totalResults'];
      _logger.info('fetched ${videoIds.length} from total:$total');
      if (!updateProgress(false, videoIds.length, total)) return failure;

      nextPageToken = jsonData['nextPageToken'] ?? '';
      isNextPageAvailable = nextPageToken.isNotEmpty;
    }
    _logger.info('fetched ${videoIds.length} for playlist: $playlistId');

    final videosDao = VideosDao(Database());
    final videosInDB = await videosDao.getVideosById(videoIds.toSet());
    final videosValidInDB = videosInDB
        .where((v) => v.updatedAt.isAfter(isAfter))
        .map((v) => v.id)
        .toSet();
    final items = videoIds.where((v) => !videosValidInDB.contains(v)).toList();
    _logger.info(
      'videosInDB:${videosInDB.length} valid:${videosValidInDB.length} needsUpdate:${items.length}',
    );

    if (!updateProgress(true, 0, items.length)) return failure;
    for (var i = 0; i < items.length; i += 50) {
      final end = (i + 50).clamp(0, items.length);
      _logger.info('syncing videos [$i-$end] of ${items.length} items');
      final batch = items.sublist(i, end);
      final syncResult = await _forceSyncVideosWithSETag(
        ref,
        Map.fromEntries(batch.map((b) => MapEntry(b, null))),
      );
      if (syncResult.isError()) {
        return Failure(syncResult.exceptionOrNull()!);
      }
      if (!updateProgress(true, i + 1, items.length)) return failure;
    }

    final videoIdsSet = <String>{};
    for (final videoId in videoIds) {
      if (videoIdsSet.contains(videoId)) {
        continue;
      }
      videoIdsSet.add(videoId);
    }
    _logger.info(
      'inserting videos:${videoIdsSet.length} duplicates:${videoIds.length - videoIdsSet.length}',
    );

    final validVideosSet = (await videosDao.getVideosById(
      videoIdsSet,
    )).map((v) => v.id).toSet();
    final missedVideosCount = videoIdsSet.length - validVideosSet.length;
    if (missedVideosCount != 0) {
      _logger.warning('video ids missed in sync results: $missedVideosCount');
    }
    final videoIdsToInsert = <String>[];
    for (final videoId in videoIds) {
      if (validVideosSet.contains(videoId)) {
        videoIdsToInsert.add(videoId);
      }
    }

    await playlistDao.upsertVideos(playlistId, videoIdsToInsert);

    return Success(Unit);
  }

  static Future<Result<void>> _forceSyncChannelsWithSETag(
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
    } else {
      ApiKeyUtil.addQuota(ref, .updateChannel, 1);
    }

    final jsonData = jsonResult.getOrThrow();
    final items = jsonData['items'] as List;

    final database = Database();
    final channelsDao = ChannelsDao(database);

    for (final item in items) {
      String setag = channelsVsSETag[item['id'] as String]!;
      await channelsDao.upsertChannelJsonData(item, setag: setag);
    }

    _logger.info('synchronized ${channelsVsSETag.length} channels to db');
    return Success(Unit);
  }

  static Future<Result<void>> _forceSyncVideosWithSETag(
    WidgetRef ref,
    Map<String, String?> videosVsSETag,
  ) async {
    final jsonResult = await _getJsonResponse(
      ref,
      'SyncVideos',
      '$_videosBaseUrl?key=API_KEY&part=contentDetails,snippet,statistics,status&id=${videosVsSETag.keys.join(",")}',
    );

    if (jsonResult.isError()) {
      return Failure(jsonResult.exceptionOrNull()!);
    } else {
      ApiKeyUtil.addQuota(ref, .updateVideo, 1);
    }

    final jsonData = jsonResult.getOrThrow();
    final items = jsonData['items'] as List;

    final database = Database();
    final videosDao = VideosDao(database);

    for (final item in items) {
      final setag = videosVsSETag[item['id']];
      await videosDao.upsertVideoJsonData(item, setag: setag);
    }

    _logger.info('synchronized ${videosVsSETag.length}');
    return Success(Unit);
  }

  static Future<Result<void>> _forceSyncChannels(
    WidgetRef ref,
    Set<String> channelIds,
  ) async {
    final jsonResult = await _getJsonResponse(
      ref,
      'SyncChannels',
      '$_channelsBaseUrl?key=API_KEY&part=contentDetails,snippet,statistics,status&id=${channelIds.join(",")}',
    );

    if (jsonResult.isError()) {
      return Failure(jsonResult.exceptionOrNull()!);
    } else {
      ApiKeyUtil.addQuota(ref, .updateChannel, 1);
    }

    final jsonData = jsonResult.getOrThrow();
    final items = jsonData['items'] as List;

    final database = Database();
    final channelsDao = ChannelsDao(database);

    for (final item in items) {
      await channelsDao.upsertChannelJsonData(item);
    }

    _logger.info('synchronized ${channelIds.length} channels to db');
    return Success(Unit);
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
