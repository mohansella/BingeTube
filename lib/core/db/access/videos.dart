import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/videos.g.dart';

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
  late ChannelsDao _channelsDao;
  VideosDao(super.attachedDatabase) {
    _channelsDao = ChannelsDao(attachedDatabase);
  }

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
      await into(videoProgress).insert(progress, mode: .insertOrIgnore);
    });
  }

  Future<void> upsertVideoProgress(
    String id,
    bool isFinished, {
    double? pos,
  }) async {
    final nowTime = DateTime.now();
    final comp = VideoProgressCompanion.insert(
      id: id,
      updatedAt: Value(nowTime),
      isFinished: Value(isFinished),
      watchPosition: pos == null ? Value.absent() : Value(pos.floor()),
    );
    await into(videoProgress).insert(comp, mode: .insertOrReplace);
  }

  JoinedSelectStatement<HasResultSet, dynamic> joinVideoAndChannelTables({
    JoinedSelectStatement<HasResultSet, dynamic>? selectStatement,
  }) {
    final c = channels;
    final v = videos;
    final s = videoSnippets;
    final t = videoThumbnails;
    final cd = videoContentDetails;
    final su = videoStatuses;
    final si = videoStatistics;
    final p = videoProgress;

    final sel = selectStatement ?? select(v).join([]);
    final query = sel.join([
      innerJoin(c, c.id.equalsExp(v.channelId)),
      innerJoin(s, s.id.equalsExp(v.id)),
      innerJoin(t, t.id.equalsExp(v.id)),
      innerJoin(cd, cd.id.equalsExp(v.id)),
      innerJoin(su, su.id.equalsExp(v.id)),
      innerJoin(si, si.id.equalsExp(v.id)),
      innerJoin(p, p.id.equalsExp(v.id)),
    ]);

    return _channelsDao.joinChannelTables(selectStatement: query);
  }

  VideoModel mapRowToModel(TypedResult result) {
    return VideoModel(
      video: result.readTable(videos),
      snippet: result.readTable(videoSnippets),
      thumbnails: result.readTable(videoThumbnails),
      contentDetails: result.readTable(videoContentDetails),
      status: result.readTable(videoStatuses),
      statistics: result.readTable(videoStatistics),
      progressData: result.readTable(videoProgress),
      channel: _channelsDao.mapRowToModel(result),
    );
  }

  Future<List<Video>> getVideosById(List<String> videoIds) async {
    final query = select(videos);
    query.where((id) => videos.id.isIn(videoIds));
    return query.get();
  }

  Future<VideoModel> getVideoModelById(String videoId) async {
    final query = joinVideoAndChannelTables()..where(videos.id.equals(videoId));
    final result = await query.getSingle();
    return mapRowToModel(result);
  }

  Future<void> upsertVideoJsonData(item, {String? setag}) async {
    final updatedAt = Value(DateTime.now());
    final id = item['id'];

    //order: video, snippet, thumbnails, contentDetails, statuses, statistics, progress
    final snippet = item['snippet'];
    final videoComp = VideosCompanion.insert(
      id: id,
      channelId: snippet['channelId'],
      etag: Value(item['etag']),
      setag: setag == null ? Value.absent() : Value(setag),
      updatedAt: updatedAt,
    );

    final snippetComp = VideoSnippetsCompanion.insert(
      id: id,
      publishedAt: DateTime.parse(snippet['publishedAt']),
      title: snippet['title'],
      description: snippet['description'],
      channelTitle: snippet['channelTitle'],
      updatedAt: updatedAt,
    );

    final thumbnails = snippet['thumbnails'];
    final thumbnailComp = VideoThumbnailsCompanion.insert(
      id: id,
      defaultUrl: thumbnails['default']['url'],
      mediumUrl: thumbnails['medium']['url'],
      highUrl: thumbnails['high']['url'],
      standardUrl: thumbnails['standard'] == null
          ? Value.absent()
          : Value(thumbnails['standard']['url']),
      maxresUrl: thumbnails['maxres'] == null
          ? Value.absent()
          : Value(thumbnails['maxres']['url']),
      updatedAt: updatedAt,
    );

    final contentDetails = item['contentDetails'];
    final contentDetailsComp = VideoContentDetailsCompanion.insert(
      id: id,
      duration: contentDetails['duration'],
      dimension: contentDetails['dimension'],
      definition: contentDetails['definition'],
      caption: contentDetails['caption'],
      licensedContent: contentDetails['licensedContent'],
      projection: contentDetails['projection'],
      updatedAt: updatedAt,
    );

    final status = item['status'];
    final statusComp = VideoStatusesCompanion.insert(
      id: id,
      uploadStatus: status['uploadStatus'],
      privacyStatus: status['privacyStatus'],
      license: status['license'],
      embeddable: status['embeddable'],
      publicStatsViewable: status['publicStatsViewable'],
      madeForKids: status['madeForKids'],
      updatedAt: updatedAt,
    );

    final statistics = item['statistics'];
    final statisticsComp = VideoStatisticsCompanion.insert(
      id: id,
      viewCount: int.parse(statistics['viewCount']),
      likeCount: statistics['likeCount'] == null
          ? Value.absent()
          : Value(int.parse(statistics['likeCount'])),
      dislikeCount: statistics['dislikeCount'] == null
          ? Value.absent()
          : Value(int.parse(statistics['dislikeCount'])),
      favoriteCount: int.parse(statistics['favoriteCount']),
      commentCount: statistics['commentCount'] == null
          ? Value.absent()
          : Value(int.parse(statistics['commentCount'])),
      updatedAt: updatedAt,
    );

    final progressComp = VideoProgressCompanion.insert(id: id);

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
