import 'package:drift/drift.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/playlists.dart';

part '../../../generated/core/db/access/playlists.g.dart';

class PlaylistModels {
  final PlaylistModel? uploads;
  final PlaylistModel? likes;
  final List<PlaylistModel> normals;

  PlaylistModels({
    required this.uploads,
    required this.likes,
    required this.normals,
  });
}

class PlaylistModel {
  final Playlist playlist;
  final PlaylistSnippet snippet;
  final PlaylistThumbnail thumbnails;
  final PlaylistContentDetail details;

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

  Future<PlaylistModels> getPlaylistModels(String channelId) async {
    final query = _joinChannelTables()..where(channels.id.equals(channelId));
    final results = await query.get();
    return mapRowsToModels(results);
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinChannelTables({
    JoinedSelectStatement<HasResultSet, dynamic>? selectStatement,
  }) {
    final sel = selectStatement ?? select(playlists).join([]);
    final query = sel.join([
      innerJoin(playlistSnippets, playlistSnippets.id.equalsExp(channels.id)),
      innerJoin(
        playlistThumbnails,
        playlistThumbnails.id.equalsExp(channels.id),
      ),
      innerJoin(
        playlistContentDetails,
        playlistContentDetails.id.equalsExp(channels.id),
      ),
    ]);

    return query;
  }

  PlaylistModel mapRowToModel(TypedResult result) {
    return PlaylistModel(
      playlist: result.readTable(playlists),
      snippet: result.readTable(playlistSnippets),
      thumbnails: result.readTable(playlistThumbnails),
      details: result.readTable(playlistContentDetails),
    );
  }

  PlaylistModels mapRowsToModels(List<TypedResult> results) {
    PlaylistModel? uploads;
    PlaylistModel? likes;
    List<PlaylistModel> normals = [];
    for (final result in results) {
      final model = mapRowToModel(result);
      final type = model.playlist.type;
      if (type == .uploads) {
        uploads = model;
      } else if (type == .likes) {
        likes = model;
      } else {
        normals.add(model);
      }
    }

    return PlaylistModels(uploads: uploads, likes: likes, normals: normals);
  }

  Future<void> _upsertPlaylistModel(
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

  Future<void> upsertChannelJsonData(
    item, {
    required int priority,
    required PlaylistType type,
  }) async {
    final updatedAt = Value(DateTime.now());

    final id = item['id'];
    final snippet = item['snippet'];
    final playlistComp = PlaylistsCompanion.insert(
      id: id,
      priority: priority,
      type: type,
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

    _upsertPlaylistModel(playlistComp, snippetComp, thumbComp, detailComp);
  }
}
