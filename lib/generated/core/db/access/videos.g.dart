// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../core/db/access/videos.dart';

// ignore_for_file: type=lint
mixin _$VideosDaoMixin on DatabaseAccessor<Database> {
  $ChannelsTable get channels => attachedDatabase.channels;
  $VideosTable get videos => attachedDatabase.videos;
  $VideoSnippetsTable get videoSnippets => attachedDatabase.videoSnippets;
  $VideoThumbnailsTable get videoThumbnails => attachedDatabase.videoThumbnails;
  $VideoContentDetailsTable get videoContentDetails =>
      attachedDatabase.videoContentDetails;
  $VideoStatusesTable get videoStatuses => attachedDatabase.videoStatuses;
  $VideoStatisticsTable get videoStatistics => attachedDatabase.videoStatistics;
  $VideoProgressTable get videoProgress => attachedDatabase.videoProgress;
  VideosDaoManager get managers => VideosDaoManager(this);
}

class VideosDaoManager {
  final _$VideosDaoMixin _db;
  VideosDaoManager(this._db);
  $$ChannelsTableTableManager get channels =>
      $$ChannelsTableTableManager(_db.attachedDatabase, _db.channels);
  $$VideosTableTableManager get videos =>
      $$VideosTableTableManager(_db.attachedDatabase, _db.videos);
  $$VideoSnippetsTableTableManager get videoSnippets =>
      $$VideoSnippetsTableTableManager(_db.attachedDatabase, _db.videoSnippets);
  $$VideoThumbnailsTableTableManager get videoThumbnails =>
      $$VideoThumbnailsTableTableManager(
        _db.attachedDatabase,
        _db.videoThumbnails,
      );
  $$VideoContentDetailsTableTableManager get videoContentDetails =>
      $$VideoContentDetailsTableTableManager(
        _db.attachedDatabase,
        _db.videoContentDetails,
      );
  $$VideoStatusesTableTableManager get videoStatuses =>
      $$VideoStatusesTableTableManager(_db.attachedDatabase, _db.videoStatuses);
  $$VideoStatisticsTableTableManager get videoStatistics =>
      $$VideoStatisticsTableTableManager(
        _db.attachedDatabase,
        _db.videoStatistics,
      );
  $$VideoProgressTableTableManager get videoProgress =>
      $$VideoProgressTableTableManager(_db.attachedDatabase, _db.videoProgress);
}
