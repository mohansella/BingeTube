import 'package:drift/drift.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/playlists.dart';
import 'package:bingetube/core/db/access/channels.dart';

part '../../../generated/core/db/access/playlists.g.dart';

class PlaylistModel {
  final Playlists playlist;
  final PlaylistSnippets snippet;
  final PlaylistThumbnails thumbnails;
  final PlaylistContentDetails details;

  PlaylistModel({
    required this.playlist,
    required this.snippet,
    required this.thumbnails,
    required this.details,
  });
}

@DriftAccessor(
  tables: [
    Playlists,
    PlaylistSnippets,
    PlaylistThumbnails,
    PlaylistContentDetails,
  ],
)
class PlaylistsDao extends DatabaseAccessor<Database> with _$PlaylistsDaoMixin {
  PlaylistsDao(super.attachedDatabase);

  Future<void> upsertPlaylistModel(
    PlaylistsCompanion playlist,
    PlaylistSnippetsCompanion snippet,
    PlaylistThumbnailsCompanion thumbnails,
    PlaylistContentDetailsCompanion details,
  ) async {
    await transaction(() async {
      await into(playlists).insert(playlist, mode: .insertOrReplace);
      await into(playlistSnippets).insert(snippet, mode: .insertOrReplace);
      await into(playlistThumbnails).insert(thumbnails, mode: .insertOrReplace);
      await into(
        playlistContentDetails,
      ).insert(details, mode: .insertOrReplace);
    });
  }

  Future<void> upsertChannelJsonData(item, {int priority = 0}) async {
    final updatedAt = Value(DateTime.now());

    final id = item['id'];
    final snippet = item['snippet'];
    final playlistComp = PlaylistsCompanion.insert(
      id: id,
      priority: priority,
      channelId: snippet['channelId'],
      updatedAt: updatedAt,
    );

    final snippetComp = PlaylistSnippetsCompanion.insert(
      id: id,
      publishedAt: DateTime.parse(snippet['publishedAt']),
      title: snippet['title'],
      description: snippet['description'],
      channelTitle: snippet['channelTitle'],
      updatedAt: updatedAt,
    );

    final thumbnails = item['thumbnails'];
    final thumbComp = PlaylistThumbnailsCompanion.insert(
      id: id,
      defaultUrl: thumbnails['default']['url'],
      mediumUrl: thumbnails['medium']['url'],
      highUrl: thumbnails['high']['url'],
      updatedAt: updatedAt,
    );

    final details = item['contentDetails'];
    final detailComp = PlaylistContentDetailsCompanion.insert(
      id: id,
      itemCount: details['itemCount'],
      updatedAt: updatedAt,
    );

    upsertPlaylistModel(playlistComp, snippetComp, thumbComp, detailComp);
  }
}
