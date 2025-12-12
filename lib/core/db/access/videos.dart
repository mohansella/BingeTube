import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/videos.g.dart';

class VideoModel {
  final Video video;
  final VideoSnippet snippet;
  final VideoThumbnail thumbnails;
  final VideoContentDetail contentDetails;
  final VideoStatuse status;
  final VideoStatistic statistics;
  final VideoProgressData progress;
  final ChannelModel channel;

  VideoModel({
    required this.video,
    required this.snippet,
    required this.thumbnails,
    required this.contentDetails,
    required this.status,
    required this.statistics,
    required this.progress,
    required this.channel,
  });
}

@DriftAccessor(
  tables: [
    Videos,
    VideoSnippets,
    VideoThumbnails,
    VideoContentDetails,
    VideoStatuses,
    VideoStatistics,
    VideoProgress,
  ],
)
class VideosDao extends DatabaseAccessor<Database> with _$VideosDaoMixin {
  VideosDao(super.attachedDatabase);

  Future<void> upsertVideoModel(
    VideosCompanion video,
    VideoSnippetsCompanion snippet,
    VideoThumbnailsCompanion thumbnails,
    VideoContentDetailsCompanion contentDetails,
    VideoStatusesCompanion status,
    VideoStatisticsCompanion statistics,
    VideoProgressCompanion progress,
  ) async {
    await transaction(() async {
      await into(videos).insert(video, mode: .insertOrReplace);
      await into(videoSnippets).insert(snippet, mode: .insertOrReplace);
      await into(videoThumbnails).insert(thumbnails, mode: .insertOrReplace);
      await into(
        videoContentDetails,
      ).insert(contentDetails, mode: .insertOrReplace);
      await into(videoStatuses).insert(status, mode: .insertOrReplace);
      await into(videoStatistics).insert(statistics, mode: .insertOrReplace);
      await into(videoProgress).insert(progress, mode: .insertOrReplace);
    });
  }

  Future<List<VideoModel>> getVideoModelByIds(List<String> videoIds) async {
    final v = videos;
    final s = videoSnippets;
    final t = videoThumbnails;
    final cd = videoContentDetails;
    final su = videoStatuses;
    final si = videoStatistics;
    final p = videoProgress;

    final query = select(v).join([
      innerJoin(s, s.id.equalsExp(v.id)),
      innerJoin(t, t.id.equalsExp(v.id)),
      innerJoin(cd, cd.id.equalsExp(v.id)),
      innerJoin(su, su.id.equalsExp(v.id)),
      innerJoin(si, si.id.equalsExp(v.id)),
      innerJoin(p, p.id.equalsExp(v.id)),
    ])..where(v.id.isIn(videoIds));

    final results = await query.get();

    //get channel models map to build video models
    final channelIds = results.map((r) => r.readTable(v).channelId).toList();
    final channelModels = await ChannelsDao(
      attachedDatabase,
    ).getChannelModelByIds(channelIds);
    final channelIdVsModels = Map.fromEntries(
      channelModels.map((m) => MapEntry(m.channel.id, m)),
    );

    final videoModels = results.map((result) {
      final video = result.readTable(v);
      return VideoModel(
        video: video,
        snippet: result.readTable(s),
        thumbnails: result.readTable(t),
        contentDetails: result.readTable(cd),
        status: result.readTable(su),
        statistics: result.readTable(si),
        progress: result.readTable(p),
        channel: channelIdVsModels[video.channelId]!,
      );
    }).toList();

    final idVsModel = Map.fromEntries(
      videoModels.map((m) => MapEntry(m.video.id, m)),
    );
    return videoIds.map((id) => idVsModel[id]!).toList();
  }

  Future<List<Video>> getVideosById(List<String> videoIds) async {
    final query = select(videos);
    query.where((id) => videos.id.isIn(videoIds));
    return query.get();
  }

  Future<void> upsertVideoJsonData(item, {String? setag}) async {
    final updatedAt = Value(DateTime.now());
    final id = Value(item['id'] as String);

    //order: video, snippet, thumbnails, contentDetails, statuses, statistics, progress
    final snippet = item['snippet'];
    final videoComp = VideosCompanion(
      id: id,
      channelId: Value(snippet['channelId']),
      etag: Value(item['etag']),
      setag: setag == null ? Value.absent() : Value(setag),
      updatedAt: updatedAt,
    );

    final snippetComp = VideoSnippetsCompanion(
      id: id,
      publishedAt: Value(DateTime.parse(snippet['publishedAt'])),
      title: Value(snippet['title']),
      description: Value(snippet['description']),
      channelTitle: Value(snippet['channelTitle']),
      updatedAt: updatedAt,
    );

    final thumbnails = snippet['thumbnails'];
    final thumbnailComp = VideoThumbnailsCompanion(
      id: id,
      defaultUrl: Value(thumbnails['default']['url']),
      mediumUrl: Value(thumbnails['medium']['url']),
      highUrl: Value(thumbnails['high']['url']),
      standardUrl: thumbnails['standard'] == null
          ? Value.absent()
          : Value(thumbnails['standard']['url']),
      maxresUrl: thumbnails['maxres'] == null
          ? Value.absent()
          : Value(thumbnails['maxres']['url']),
      updatedAt: updatedAt,
    );

    final contentDetails = item['contentDetails'];
    final contentDetailsComp = VideoContentDetailsCompanion(
      id: id,
      duration: Value(contentDetails['duration']),
      dimension: Value(contentDetails['dimension']),
      definition: Value(contentDetails['definition']),
      caption: Value(contentDetails['caption']),
      licensedContent: Value(contentDetails['licensedContent']),
      projection: Value(contentDetails['projection']),
      updatedAt: updatedAt,
    );

    final status = item['status'];
    final statusComp = VideoStatusesCompanion(
      id: id,
      uploadStatus: Value(status['uploadStatus']),
      privacyStatus: Value(status['privacyStatus']),
      license: Value(status['license']),
      embeddable: Value(status['embeddable']),
      publicStatsViewable: Value(status['publicStatsViewable']),
      madeForKids: Value(status['madeForKids']),
      updatedAt: updatedAt,
    );

    final statistics = item['statistics'];
    final statisticsComp = VideoStatisticsCompanion(
      id: id,
      viewCount: Value(int.parse(statistics['viewCount'])),
      likeCount: statistics['likeCount'] == null
          ? Value.absent()
          : Value(int.parse(statistics['likeCount'])),
      dislikeCount: statistics['dislikeCount'] == null
          ? Value.absent()
          : Value(int.parse(statistics['dislikeCount'])),
      favoriteCount: Value(int.parse(statistics['favoriteCount'])),
      commentCount: Value(int.parse(statistics['commentCount'])),
      updatedAt: updatedAt,
    );

    final progressComp = VideoProgressCompanion(id: id);

    await upsertVideoModel(
      videoComp,
      snippetComp,
      thumbnailComp,
      contentDetailsComp,
      statusComp,
      statisticsComp,
      progressComp,
    );
  }
}
