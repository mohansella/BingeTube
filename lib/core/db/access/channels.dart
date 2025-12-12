import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/channels.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/channels.g.dart';

class ChannelModel {
  final Channel channel;
  final ChannelSnippet snippet;
  final ChannelThumbnail thumbnails;
  final ChannelContentDetail contentDetails;
  final ChannelStatistic statistics;
  final ChannelStatuse status;

  ChannelModel({
    required this.channel,
    required this.snippet,
    required this.thumbnails,
    required this.contentDetails,
    required this.statistics,
    required this.status,
  });
}

@DriftAccessor(
  tables: [
    Channels,
    ChannelSnippets,
    ChannelThumbnails,
    ChannelContentDetails,
    ChannelStatistics,
    ChannelStatuses,
  ],
)
class ChannelsDao extends DatabaseAccessor<Database> with _$ChannelsDaoMixin {
  ChannelsDao(super.db);

  Future<void> upsertChannel(ChannelsCompanion channel) async {
    await into(channels).insert(channel, mode: .insertOrReplace);
  }

  Future<void> upsertChannelModel(
    ChannelsCompanion channel,
    ChannelSnippetsCompanion snippet,
    ChannelThumbnailsCompanion thumbnails,
    ChannelContentDetailsCompanion contentDetails,
    ChannelStatisticsCompanion statistics,
    ChannelStatusesCompanion status,
  ) async {
    await transaction(() async {
      await into(channels).insert(channel, mode: .insertOrReplace);
      await into(channelSnippets).insert(snippet, mode: .insertOrReplace);
      await into(channelThumbnails).insert(thumbnails, mode: .insertOrReplace);
      await into(
        channelContentDetails,
      ).insert(contentDetails, mode: .insertOrReplace);
      await into(channelStatistics).insert(statistics, mode: .insertOrReplace);
      await into(channelStatuses).insert(status, mode: .insertOrReplace);
    });
  }

  Future<List<ChannelModel>> getChannelModelByIds(
    List<String> channelIds,
  ) async {
    final c = channels;
    final s = channelSnippets;
    final t = channelThumbnails;
    final cd = channelContentDetails;
    final st = channelStatistics;
    final cs = channelStatuses;

    final query = select(c).join([
      innerJoin(s, s.id.equalsExp(c.id)),
      innerJoin(t, t.id.equalsExp(c.id)),
      innerJoin(cd, cd.id.equalsExp(c.id)),
      innerJoin(st, st.id.equalsExp(c.id)),
      innerJoin(cs, cs.id.equalsExp(c.id)),
    ])..where(c.id.isIn(channelIds));

    final results = await query.get();
    final channelModels = results.map((result) {
      return ChannelModel(
        channel: result.readTable(c),
        snippet: result.readTable(s),
        thumbnails: result.readTable(t),
        contentDetails: result.readTable(cd),
        statistics: result.readTable(st),
        status: result.readTable(cs),
      );
    }).toList();
    final idVsModel = Map.fromEntries(
      channelModels.map((m) => MapEntry(m.channel.id, m)),
    );
    return channelIds.map((id) => idVsModel[id]!).toList();
  }

  Future<List<Channel>> getChannelsById(List<String> channelIds) async {
    final query = select(channels);
    query.where((id) => channels.id.isIn(channelIds));
    return query.get();
  }

  Future<void> upsertChannelJsonData(item, {String? setag}) async {
    final updatedAt = Value(DateTime.now());
    final id = Value(item['id'] as String);

    //order: (channel, snippet, thumbnails, contentDetails, statistics, status)
    final channelComp = ChannelsCompanion(
      id: id,
      etag: Value(item['etag']),
      setag: setag == null ? Value.absent() : Value(setag),
      updatedAt: updatedAt,
    );

    final snippet = item['snippet'];
    final snippetComp = ChannelSnippetsCompanion(
      id: id,
      title: Value(snippet['title']),
      description: Value(snippet['description']),
      updatedAt: updatedAt,
    );

    final thumbnails = snippet['thumbnails'];
    final thumbnailsComp = ChannelThumbnailsCompanion(
      id: id,
      defaultUrl: Value(thumbnails['default']['url']),
      mediumUrl: Value(thumbnails['medium']['url']),
      highUrl: Value(thumbnails['high']['url']),
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

    await upsertChannelModel(
      channelComp,
      snippetComp,
      thumbnailsComp,
      contentComp,
      statisticsComp,
      statusComp,
    );
  }
}
