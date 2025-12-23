import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/search.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/search.g.dart';

class ChannelSearchModel {
  final ChannelSearche meta;
  final List<ChannelModel> channels;

  ChannelSearchModel(this.meta, this.channels);
}

class VideoSearchModel {
  final VideoSearche meta;
  final List<VideoModel> videos;

  VideoSearchModel(this.meta, this.videos);
}

@DriftAccessor(
  tables: [
    ChannelSearches,
    ChannelSearchVsChannels,
    VideoSearches,
    VideoSearchVsVideos,
  ],
)
class SearchDao extends DatabaseAccessor<Database> with _$SearchDaoMixin {
  late ChannelsDao _channelsDao;
  late VideosDao _videosDao;
  SearchDao(super.attachedDatabase) {
    _channelsDao = ChannelsDao(attachedDatabase);
    _videosDao = VideosDao(attachedDatabase);
  }

  Future<void> insertChannelSearch(
    String searchValue,
    List<String> channelIds,
  ) async {
    await transaction(() async {
      final prevEntryQuery = select(channelSearches)
        ..where((q) => channelSearches.query.equals(searchValue));
      final prevEntry = await prevEntryQuery.getSingleOrNull();

      final nowTime = Value(DateTime.now());
      final searchId = await into(channelSearches).insert(
        ChannelSearchesCompanion(
          id: prevEntry == null ? Value.absent() : Value(prevEntry.id),
          query: Value(searchValue),
          updatedAt: nowTime,
        ),
        mode: .insertOrReplace,
      );

      //delete previous mappings since new results might give different set of channels
      final deleteQuery = delete(channelSearchVsChannels)
        ..where((q) => channelSearchVsChannels.searchId.equals(searchId));
      await deleteQuery.go();

      var priority = 1;
      for (final channelId in channelIds) {
        await into(channelSearchVsChannels).insert(
          ChannelSearchVsChannelsCompanion(
            searchId: Value(searchId),
            channelId: Value(channelId),
            priority: Value(priority++),
          ),
        );
      }
    });
  }

  Future<void> insertVideoSearch(
    String searchValue,
    List<String> videoIds,
  ) async {
    await transaction(() async {
      final prevEntryQuery = select(videoSearches)
        ..where((q) => videoSearches.query.equals(searchValue));
      final prevEntry = await prevEntryQuery.getSingleOrNull();

      final nowTime = Value(DateTime.now());
      final searchId = await into(videoSearches).insert(
        VideoSearchesCompanion(
          id: prevEntry == null ? Value.absent() : Value(prevEntry.id),
          query: Value(searchValue),
          updatedAt: nowTime,
        ),
        mode: .insertOrReplace,
      );

      //delete previous mappings since new results might give different set of videos
      final deleteQuery = delete(videoSearchVsVideos)
        ..where((q) => videoSearchVsVideos.searchId.equals(searchId));
      await deleteQuery.go();

      var priority = 1;
      for (final videoId in videoIds) {
        await into(videoSearchVsVideos).insert(
          VideoSearchVsVideosCompanion(
            searchId: Value(searchId),
            videoId: Value(videoId),
            priority: Value(priority++),
          ),
        );
      }
    });
  }

  JoinedSelectStatement<HasResultSet, dynamic> queryChannelModels(
    String searchValue,
  ) {
    final cs = channelSearches;
    final svc = channelSearchVsChannels;
    final c = channels;
    var selectStatement = select(cs).join([
      innerJoin(svc, svc.searchId.equalsExp(cs.id)),
      innerJoin(c, c.id.equalsExp(svc.channelId)),
    ]);
    final query =
        _channelsDao.joinChannelTables(selectStatement: selectStatement)
          ..where(cs.query.equals(searchValue))
          ..orderBy([OrderingTerm.asc(svc.priority)]);
    return query;
  }

  JoinedSelectStatement<HasResultSet, dynamic> queryVideoModels() {
    final vs = videoSearches;
    final vvv = videoSearchVsVideos;
    final v = videos;
    var selectStatement = select(vs).join([
      innerJoin(vvv, vvv.searchId.equalsExp(vs.id)),
      innerJoin(v, v.id.equalsExp(vvv.videoId)),
    ]);
    final query = _videosDao.joinVideoAndChannelTables(
      selectStatement: selectStatement,
    )..orderBy([OrderingTerm.asc(vvv.priority)]);
    return query;
  }

  Future<ChannelSearchModel?> getChannelSearchModel(String searchValue) async {
    final query = queryChannelModels(searchValue);
    final results = await query.get();
    if (results.isEmpty) {
      return null;
    }

    final channelModels = results.map(_channelsDao.mapRowToModel).toList();
    return ChannelSearchModel(
      results[0].readTable(channelSearches),
      channelModels,
    );
  }

  Future<VideoSearchModel?> getVideoSearchModel(String searchValue) async {
    final query = queryVideoModels()
      ..where(videoSearches.query.equals(searchValue));
    final results = await query.get();
    if (results.isEmpty) {
      return null;
    }

    return VideoSearchModel(
      results[0].readTable(videoSearches),
      results.map(_videosDao.mapRowToModel).toList(),
    );
  }

  Stream<VideoSearchModel> streamVideoSearchModel(int searchId) {
    final query = queryVideoModels()..where(videoSearches.id.equals(searchId));
    return query.watch().map((results) {
      return VideoSearchModel(
        results[0].readTable(videoSearches),
        results.map(_videosDao.mapRowToModel).toList(),
      );
    });
  }
}
