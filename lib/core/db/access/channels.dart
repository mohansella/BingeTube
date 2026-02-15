import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/channel_model.dart';
import 'package:bingetube/core/db/tables/channels.dart';
import 'package:bingetube/core/lang/extensions.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/channels.g.dart';

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
  static final _logger = LogManager.getLogger('ChannelsDao');

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

  JoinedSelectStatement<HasResultSet, dynamic> joinChannelTables({
    JoinedSelectStatement<HasResultSet, dynamic>? selectStatement,
  }) {
    final sel = selectStatement ?? select(channels).join([]);
    final query = sel.join([
      innerJoin(channelSnippets, channelSnippets.id.equalsExp(channels.id)),
      innerJoin(channelThumbnails, channelThumbnails.id.equalsExp(channels.id)),
      innerJoin(
        channelContentDetails,
        channelContentDetails.id.equalsExp(channels.id),
      ),
      innerJoin(channelStatistics, channelStatistics.id.equalsExp(channels.id)),
      innerJoin(channelStatuses, channelStatuses.id.equalsExp(channels.id)),
    ]);

    return query;
  }

  ChannelModel mapRowToModel(TypedResult result) {
    return ChannelModel(
      channel: result.readTable(channels),
      snippet: result.readTable(channelSnippets),
      thumbnails: result.readTable(channelThumbnails),
      contentDetails: result.readTable(channelContentDetails),
      statistics: result.readTable(channelStatistics),
      status: result.readTable(channelStatuses),
    );
  }

  Future<ChannelModel> getChannelModelById(String channelId) async {
    final query = joinChannelTables(selectStatement: select(channels).join([]))
      ..where(channels.id.equals(channelId));

    final result = await query.getSingle();
    return mapRowToModel(result);
  }

  Future<List<ChannelModel>> getChannelModelByIds(
    Set<String> channelIds,
  ) async {
    final query = joinChannelTables(selectStatement: select(channels).join([]))
      ..where(channels.id.isIn(channelIds));

    final results = await query.get();
    final channelModels = results.map(mapRowToModel).toList();
    return channelModels;
  }

  Future<List<Channel>> getChannelsById(List<String> channelIds) async {
    final query = select(channels);
    query.where((id) => channels.id.isIn(channelIds));
    return query.get();
  }

  Future<void> upsertChannelJsonData(item, {String? setag}) async {
    final updatedAt = Value(DateTime.now());
    final id = item['id'];

    //order: (channel, snippet, thumbnails, contentDetails, statistics, status)
    final channelComp = ChannelsCompanion.insert(
      id: id,
      etag: Value(item['etag']),
      setag: setag == null ? Value.absent() : Value(setag),
      updatedAt: updatedAt,
    );

    final snippet = item['snippet'];
    final snippetComp = ChannelSnippetsCompanion.insert(
      id: id,
      title: snippet['title'],
      description: snippet['description'],
    );

    final thumbnails = snippet['thumbnails'];
    final thumbnailsComp = ChannelThumbnailsCompanion.insert(
      id: id,
      defaultUrl: thumbnails['default']['url'],
      mediumUrl: thumbnails['medium']['url'],
      highUrl: thumbnails['high']['url'],
    );

    final playlists = item['contentDetails']['relatedPlaylists'];
    final likePlaylist = playlists['likes'];
    final uploadPlaylist = playlists['uploads'];
    final contentComp = ChannelContentDetailsCompanion.insert(
      id: id,
      likesPlaylist: likePlaylist == null
          ? Value.absent()
          : Value(likePlaylist),
      uploadPlaylist: uploadPlaylist == null
          ? Value.absent()
          : Value(uploadPlaylist),
    );

    final statistics = item['statistics'];
    final statisticsComp = ChannelStatisticsCompanion.insert(
      id: id,
      viewCount: int.parse(statistics['viewCount']),
      subscriberCount: int.parse(statistics['subscriberCount']),
      hiddenSubscriberCount: statistics['hiddenSubscriberCount'],
      videoCount: int.parse(statistics['videoCount']),
    );

    final status = item['status'];
    final madeForKids = status['madeForKids'];
    final statusComp = ChannelStatusesCompanion.insert(
      id: id,
      privacyStatus: status['privacyStatus'],
      isLinked: status['isLinked'],
      longUploadsStatus: status['longUploadsStatus'],
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

  Future<void> importChannelModels(
    Map<String, ChannelModel> idVsChannel,
  ) async {
    final existingIdVsChannel = <String, ChannelModel>{};
    final expiredChannelId = <String>{};
    final nowTime = DateTime.now();
    for (final chunkIds in idVsChannel.keys.toList().chunked(100)) {
      final chunkModels = await getChannelModelByIds(chunkIds.toSet());
      for (final chunkModel in chunkModels) {
        final channelId = chunkModel.channel.id;

        if (!existingIdVsChannel.containsKey(channelId)) {
          existingIdVsChannel[channelId] = chunkModel;
          final importModelTime = idVsChannel[channelId]!.channel.updatedAt;
          if (importModelTime.isBefore(nowTime) &&
              importModelTime.isAfter(chunkModel.channel.updatedAt)) {
            expiredChannelId.add(channelId);
          }
        }
      }
    }

    final neededChannelsId = idVsChannel.keys.toSet();
    for (final channelId in existingIdVsChannel.keys) {
      if (!expiredChannelId.contains(channelId)) {
        neededChannelsId.remove(channelId);
      }
    }

    ChannelsDao._logger.info(
      'importChannels:${idVsChannel.length} existingChannels:${existingIdVsChannel.length} expiredChannels:${expiredChannelId.length} neededChannels:${neededChannelsId.length}',
    );

    for (final channelId in neededChannelsId) {
      final model = idVsChannel[channelId]!;
      await upsertChannelModel(
        model.channel.toCompanion(true),
        model.snippet.toCompanion(true),
        model.thumbnails.toCompanion(true),
        model.contentDetails.toCompanion(true),
        model.statistics.toCompanion(true),
        model.status.toCompanion(true),
      );
    }
  }
}
