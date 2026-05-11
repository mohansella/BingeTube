// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../core/db/access/channels.dart';

// ignore_for_file: type=lint
mixin _$ChannelsDaoMixin on DatabaseAccessor<Database> {
  $ChannelsTable get channels => attachedDatabase.channels;
  $ChannelSnippetsTable get channelSnippets => attachedDatabase.channelSnippets;
  $ChannelThumbnailsTable get channelThumbnails =>
      attachedDatabase.channelThumbnails;
  $ChannelContentDetailsTable get channelContentDetails =>
      attachedDatabase.channelContentDetails;
  $ChannelStatisticsTable get channelStatistics =>
      attachedDatabase.channelStatistics;
  $ChannelStatusesTable get channelStatuses => attachedDatabase.channelStatuses;
  ChannelsDaoManager get managers => ChannelsDaoManager(this);
}

class ChannelsDaoManager {
  final _$ChannelsDaoMixin _db;
  ChannelsDaoManager(this._db);
  $$ChannelsTableTableManager get channels =>
      $$ChannelsTableTableManager(_db.attachedDatabase, _db.channels);
  $$ChannelSnippetsTableTableManager get channelSnippets =>
      $$ChannelSnippetsTableTableManager(
        _db.attachedDatabase,
        _db.channelSnippets,
      );
  $$ChannelThumbnailsTableTableManager get channelThumbnails =>
      $$ChannelThumbnailsTableTableManager(
        _db.attachedDatabase,
        _db.channelThumbnails,
      );
  $$ChannelContentDetailsTableTableManager get channelContentDetails =>
      $$ChannelContentDetailsTableTableManager(
        _db.attachedDatabase,
        _db.channelContentDetails,
      );
  $$ChannelStatisticsTableTableManager get channelStatistics =>
      $$ChannelStatisticsTableTableManager(
        _db.attachedDatabase,
        _db.channelStatistics,
      );
  $$ChannelStatusesTableTableManager get channelStatuses =>
      $$ChannelStatusesTableTableManager(
        _db.attachedDatabase,
        _db.channelStatuses,
      );
}
