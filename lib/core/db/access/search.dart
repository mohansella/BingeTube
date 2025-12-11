import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/search.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/search.g.dart';

@DriftAccessor(tables: [ChannelSearches, ChannelSearchVsChannels])
class SearchDao extends DatabaseAccessor<Database> with _$SearchDaoMixin {
  SearchDao(super.attachedDatabase);

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
      final deleteQuery = delete(channelSearchVsChannels);
      deleteQuery.where(
        (q) => channelSearchVsChannels.searchId.equals(searchId),
      );
      await deleteQuery.go();

      for (final channelId in channelIds) {
        await into(channelSearchVsChannels).insert(
          ChannelSearchVsChannelsCompanion(
            searchId: Value(searchId),
            channelId: Value(channelId),
          ),
        );
      }
    });
  }

  Future<ChannelSearche> getChannelSearch(String searchValue) async {
    final query = select(channelSearches)
      ..where((q) => channelSearches.query.equals(searchValue));
    return query.getSingle();
  }

  Future<List<ChannelModel>?> getChannelModels(String searchValue) async {
    final query = select(channelSearches).join([
      innerJoin(
        channelSearchVsChannels,
        channelSearchVsChannels.searchId.equalsExp(channelSearches.id),
      ),
    ]);
    query.where(channelSearches.query.equals(searchValue));
    final results = await query.get();
    if (results.isEmpty) {
      return null;
    }

    final channelIds = results
        .map((row) => row.readTable(channelSearchVsChannels).channelId)
        .toList();

    return ChannelsDao(attachedDatabase).getChannelModelByIds(channelIds);
  }
}
