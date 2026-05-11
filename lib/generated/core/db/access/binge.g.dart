// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../core/db/access/binge.dart';

// ignore_for_file: type=lint
mixin _$BingeDaoMixin on DatabaseAccessor<Database> {
  $CollectionsTable get collections => attachedDatabase.collections;
  $ChannelsTable get channels => attachedDatabase.channels;
  $VideosTable get videos => attachedDatabase.videos;
  $SeriesTable get series => attachedDatabase.series;
  $SeriesVsVideosTable get seriesVsVideos => attachedDatabase.seriesVsVideos;
  $VideoThumbnailsTable get videoThumbnails => attachedDatabase.videoThumbnails;
  $VideoProgressTable get videoProgress => attachedDatabase.videoProgress;
  $ChannelThumbnailsTable get channelThumbnails =>
      attachedDatabase.channelThumbnails;
  BingeDaoManager get managers => BingeDaoManager(this);
}

class BingeDaoManager {
  final _$BingeDaoMixin _db;
  BingeDaoManager(this._db);
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db.attachedDatabase, _db.collections);
  $$ChannelsTableTableManager get channels =>
      $$ChannelsTableTableManager(_db.attachedDatabase, _db.channels);
  $$VideosTableTableManager get videos =>
      $$VideosTableTableManager(_db.attachedDatabase, _db.videos);
  $$SeriesTableTableManager get series =>
      $$SeriesTableTableManager(_db.attachedDatabase, _db.series);
  $$SeriesVsVideosTableTableManager get seriesVsVideos =>
      $$SeriesVsVideosTableTableManager(
        _db.attachedDatabase,
        _db.seriesVsVideos,
      );
  $$VideoThumbnailsTableTableManager get videoThumbnails =>
      $$VideoThumbnailsTableTableManager(
        _db.attachedDatabase,
        _db.videoThumbnails,
      );
  $$VideoProgressTableTableManager get videoProgress =>
      $$VideoProgressTableTableManager(_db.attachedDatabase, _db.videoProgress);
  $$ChannelThumbnailsTableTableManager get channelThumbnails =>
      $$ChannelThumbnailsTableTableManager(
        _db.attachedDatabase,
        _db.channelThumbnails,
      );
}
