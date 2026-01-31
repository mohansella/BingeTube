import 'package:bingetube/core/db/tables/channels.dart';
import 'package:bingetube/core/db/tables/mixins.dart';
import 'package:drift/drift.dart';

enum PlaylistType { uploads, likes, normal }

@TableIndex(name: 'PlaylistIndexETag', columns: {#etag})
class Playlists extends Table with TableTimedMixin {
  late final id = text()();
  late final channelId = text().references(Channels, #id)();
  late final type = intEnum<PlaylistType>()();
  late final priority = integer()();
  late final etag = text()();

  @override
  get primaryKey => {id};
}

class PlaylistSnippets extends Table with TableTimedMixin {
  late final id = text().references(Playlists, #id)();
  late final publishedAt = dateTime()();
  late final title = text()();
  late final description = text()();
  late final channelTitle = text()();

  @override
  get primaryKey => {id};
}

class PlaylistThumbnails extends Table with TableTimedMixin {
  late final id = text().references(Playlists, #id)();
  late final defaultUrl = text()();
  late final mediumUrl = text()();
  late final highUrl = text()();
  late final standardUrl = text().nullable()();
  late final maxresUrl = text().nullable()();

  @override
  get primaryKey => {id};
}

class PlaylistContentDetails extends Table with TableTimedMixin {
  late final id = text().references(Playlists, #id)();
  late final itemCount = integer()();

  @override
  get primaryKey => {id};
}
