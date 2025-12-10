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

  Future<void> insertChannel(ChannelsCompanion channel) async {
    await into(channels).insert(channel, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertChannelModel(
    ChannelsCompanion channel,
    ChannelSnippetsCompanion snippet,
    ChannelThumbnailsCompanion thumbnails,
    ChannelContentDetailsCompanion contentDetails,
    ChannelStatisticsCompanion statistics,
    ChannelStatusesCompanion status,
  ) async {
    await transaction(() async {
      await into(channels).insert(channel, mode: InsertMode.insertOrReplace);
      await into(
        channelSnippets,
      ).insert(snippet, mode: InsertMode.insertOrReplace);
      await into(
        channelThumbnails,
      ).insert(thumbnails, mode: InsertMode.insertOrReplace);
      await into(
        channelContentDetails,
      ).insert(contentDetails, mode: InsertMode.insertOrReplace);
      await into(
        channelStatistics,
      ).insert(statistics, mode: InsertMode.insertOrReplace);
      await into(
        channelStatuses,
      ).insert(status, mode: InsertMode.insertOrReplace);
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
    return results.map((result) {
      return ChannelModel(
        channel: result.readTable(c),
        snippet: result.readTable(s),
        thumbnails: result.readTable(t),
        contentDetails: result.readTable(cd),
        statistics: result.readTable(st),
        status: result.readTable(cs),
      );
    }).toList();
  }

  Future<List<Channel>> getChannelsById(List<String> channelIds) async {
    final query = select(channels);
    query.where((id) => channels.id.isIn(channelIds));
    return await query.get();
  }
}
