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

  Future<void> insertChannelInfo(
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

  Future<ChannelModel?> getChannelById(String channelId) async {
    final c = channels;
    final s = channelSnippets;
    final t = channelThumbnails;
    final cd = channelContentDetails;
    final st = channelStatistics;
    final cs = channelStatuses;

    final query = select(c).join([
      leftOuterJoin(s, s.id.equalsExp(c.id)),
      leftOuterJoin(t, t.id.equalsExp(c.id)),
      leftOuterJoin(cd, cd.id.equalsExp(c.id)),
      leftOuterJoin(st, st.id.equalsExp(c.id)),
      leftOuterJoin(cs, cs.id.equalsExp(c.id)),
    ]);

    query.where(c.id.equals(channelId));

    final result = await query.getSingleOrNull();
    if (result == null) return null;

    return ChannelModel(
      channel: result.readTable(c),
      snippet: result.readTable(s),
      thumbnails: result.readTable(t),
      contentDetails: result.readTable(cd),
      statistics: result.readTable(st),
      status: result.readTable(cs),
    );
  }
}
