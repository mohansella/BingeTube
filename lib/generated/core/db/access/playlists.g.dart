// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../core/db/access/playlists.dart';

// ignore_for_file: type=lint
mixin _$PlaylistsDaoMixin on DatabaseAccessor<Database> {
  $ChannelsTable get channels => attachedDatabase.channels;
  $PlaylistsTable get playlists => attachedDatabase.playlists;
  $PlaylistSnippetsTable get playlistSnippets =>
      attachedDatabase.playlistSnippets;
  $PlaylistThumbnailsTable get playlistThumbnails =>
      attachedDatabase.playlistThumbnails;
  $PlaylistContentDetailsTable get playlistContentDetails =>
      attachedDatabase.playlistContentDetails;
  $VideosTable get videos => attachedDatabase.videos;
  $PlaylistVsVideosTable get playlistVsVideos =>
      attachedDatabase.playlistVsVideos;
  PlaylistsDaoManager get managers => PlaylistsDaoManager(this);
}

class PlaylistsDaoManager {
  final _$PlaylistsDaoMixin _db;
  PlaylistsDaoManager(this._db);
  $$ChannelsTableTableManager get channels =>
      $$ChannelsTableTableManager(_db.attachedDatabase, _db.channels);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db.attachedDatabase, _db.playlists);
  $$PlaylistSnippetsTableTableManager get playlistSnippets =>
      $$PlaylistSnippetsTableTableManager(
        _db.attachedDatabase,
        _db.playlistSnippets,
      );
  $$PlaylistThumbnailsTableTableManager get playlistThumbnails =>
      $$PlaylistThumbnailsTableTableManager(
        _db.attachedDatabase,
        _db.playlistThumbnails,
      );
  $$PlaylistContentDetailsTableTableManager get playlistContentDetails =>
      $$PlaylistContentDetailsTableTableManager(
        _db.attachedDatabase,
        _db.playlistContentDetails,
      );
  $$VideosTableTableManager get videos =>
      $$VideosTableTableManager(_db.attachedDatabase, _db.videos);
  $$PlaylistVsVideosTableTableManager get playlistVsVideos =>
      $$PlaylistVsVideosTableTableManager(
        _db.attachedDatabase,
        _db.playlistVsVideos,
      );
}
