// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../core/db/access/search.dart';

// ignore_for_file: type=lint
mixin _$SearchDaoMixin on DatabaseAccessor<Database> {
  $ChannelSearchesTable get channelSearches => attachedDatabase.channelSearches;
  $ChannelsTable get channels => attachedDatabase.channels;
  $ChannelSearchVsChannelsTable get channelSearchVsChannels =>
      attachedDatabase.channelSearchVsChannels;
  $VideoSearchesTable get videoSearches => attachedDatabase.videoSearches;
  $VideosTable get videos => attachedDatabase.videos;
  $VideoSearchVsVideosTable get videoSearchVsVideos =>
      attachedDatabase.videoSearchVsVideos;
  SearchDaoManager get managers => SearchDaoManager(this);
}

class SearchDaoManager {
  final _$SearchDaoMixin _db;
  SearchDaoManager(this._db);
  $$ChannelSearchesTableTableManager get channelSearches =>
      $$ChannelSearchesTableTableManager(
        _db.attachedDatabase,
        _db.channelSearches,
      );
  $$ChannelsTableTableManager get channels =>
      $$ChannelsTableTableManager(_db.attachedDatabase, _db.channels);
  $$ChannelSearchVsChannelsTableTableManager get channelSearchVsChannels =>
      $$ChannelSearchVsChannelsTableTableManager(
        _db.attachedDatabase,
        _db.channelSearchVsChannels,
      );
  $$VideoSearchesTableTableManager get videoSearches =>
      $$VideoSearchesTableTableManager(_db.attachedDatabase, _db.videoSearches);
  $$VideosTableTableManager get videos =>
      $$VideosTableTableManager(_db.attachedDatabase, _db.videos);
  $$VideoSearchVsVideosTableTableManager get videoSearchVsVideos =>
      $$VideoSearchVsVideosTableTableManager(
        _db.attachedDatabase,
        _db.videoSearchVsVideos,
      );
}
