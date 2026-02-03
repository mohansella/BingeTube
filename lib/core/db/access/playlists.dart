import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
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
    PlaylistVsVideos,
  ],
)
class PlaylistsDao extends DatabaseAccessor<Database> with _$PlaylistsDaoMixin {
  PlaylistsDao(super.attachedDatabase);

  Future<PlaylistModels> getPlaylistModels(String channelId) async {
    final query = _joinChannelTables()
      ..where(playlists.channelId.equals(channelId));
    final results = await query.get();
    return _mapRowsToModels(results);
  }

  Future<PlaylistModel> getPlaylistModel(String playlistId) async {
    final query = _joinChannelTables()..where(playlists.id.equals(playlistId));
    final result = await query.getSingle();
    return _mapRowToModel(result);
  }

  Stream<PlaylistModels> streamPlaylistModels(String channelId) {
    final query = _joinChannelTables()
      ..where(playlists.channelId.equals(channelId));
    return query.watch().map((r) => _mapRowsToModels(r));
  }

  Future<void> upsertVideos(String playlistId, List<String> videoIds) async {
    await transaction(() async {
      final deleteQuery = delete(playlistVsVideos)
        ..where((v) => v.playlistId.equals(playlistId));
      await deleteQuery.go();

      int priority = 1;
      for (final videoId in videoIds) {
        final vsComp = PlaylistVsVideosCompanion.insert(
          playlistId: playlistId,
          videoId: videoId,
          priority: priority++,
        );
        await into(playlistVsVideos).insert(vsComp);
      }
    });
  }

  Future<VideoModel> getFirstVideoModel(String playlistId) async {
    final models = await getVideoModels(playlistId, limit: 1);
    return models[0];
  }

  Future<List<VideoModel>> getVideoModels(
    String playlistId, {
    int? limit,
  }) async {
    final videoDao = VideosDao(db);
    final query =
        videoDao.joinVideoAndChannelTables(
            selectStatement: select(playlistVsVideos).join([
              innerJoin(videos, videos.id.equalsExp(playlistVsVideos.videoId)),
            ]),
          )
          ..where(playlistVsVideos.playlistId.equals(playlistId))
          ..orderBy([OrderingTerm.asc(playlistVsVideos.priority)]);
    if (limit != null) {
      query.limit(limit);
    }
    final results = await query.get();
    return results.map((r) => videoDao.mapRowToModel(r)).toList();
  }

  Future<BingeModel> getBingeModel(String playlistId) async {
    final playlist = await getPlaylistModel(playlistId);
    final videos = await getVideoModels(playlistId);
    return BingeModel(
      title: playlist.snippet.title,
      description: playlist.snippet.description,
      videos: videos,
    );
  }

  Future<DateTime?> getPlaylistItemsUpdateTime(String playlistId) async {
    final query =
        select(playlistVsVideos).join([
            innerJoin(videos, videos.id.equalsExp(playlistVsVideos.videoId)),
          ])
          ..where(playlistVsVideos.playlistId.equals(playlistId))
          ..orderBy([OrderingTerm.asc(videos.updatedAt)])
          ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.readTable(videos).updatedAt;
  }

  Future<void> upsertAllPlaylistItems(
    List<dynamic> normalItems, {
    required uploadItem,
    required likeItem,
  }) async {
    await transaction(() async {
      if (uploadItem != null) {
        await _upsertPlaylistJson(uploadItem, type: .uploads);
      }
      if (likeItem != null) {
        await _upsertPlaylistJson(likeItem, type: .likes);
      }
      var priority = 1;
      for (final normalItem in normalItems) {
        await _upsertPlaylistJson(
          normalItem,
          priority: priority++,
          type: .normal,
        );
      }
    });
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinChannelTables({
    JoinedSelectStatement<HasResultSet, dynamic>? selectStatement,
  }) {
    final sel = selectStatement ?? select(playlists).join([]);
    final query = sel.join([
      innerJoin(playlistSnippets, playlistSnippets.id.equalsExp(playlists.id)),
      innerJoin(
        playlistThumbnails,
        playlistThumbnails.id.equalsExp(playlists.id),
      ),
      innerJoin(
        playlistContentDetails,
        playlistContentDetails.id.equalsExp(playlists.id),
      ),
    ]);

    return query;
  }

  PlaylistModel _mapRowToModel(TypedResult result) {
    return PlaylistModel(
      playlist: result.readTable(playlists),
      snippet: result.readTable(playlistSnippets),
      thumbnails: result.readTable(playlistThumbnails),
      details: result.readTable(playlistContentDetails),
    );
  }

  PlaylistModels _mapRowsToModels(List<TypedResult> results) {
    PlaylistModel? uploads;
    PlaylistModel? likes;
    List<PlaylistModel> normals = [];
    for (final result in results) {
      final model = _mapRowToModel(result);
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

  Future<void> _upsertPlaylistJson(
    item, {
    int priority = 0,
    required PlaylistType type,
  }) async {
    final updatedAt = Value(DateTime.now());

    final id = item['id'];
    final snippet = item['snippet'];
    final playlistComp = PlaylistsCompanion.insert(
      id: id,
      etag: item['etag'],
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

    final thumbnails = snippet['thumbnails'];
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
