import 'package:bingetube/core/db/tables/channels.dart';
import 'package:bingetube/core/db/tables/mixins.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'VideosIndexETag', columns: {#etag})
class Videos extends Table with TableTimedMixin {
  late final id = text()();
  late final etag = text().nullable()();
  late final setag = text().nullable()();
  late final channelId = text().references(Channels, #id)();

  @override
  get primaryKey => {id};
}

class VideoSnippets extends Table with TableTimedMixin {
  late final id = text().references(Videos, #id)();
  late final publishedAt = dateTime()();
  late final title = text()();
  late final description = text()();
  late final channelTitle = text()();

  @override
  get primaryKey => {id};
}

class VideoThumbnails extends Table with TableTimedMixin {
  late final id = text().references(Videos, #id)();
  late final defaultUrl = text()();
  late final mediumUrl = text()();
  late final highUrl = text()();
  late final standardUrl = text().nullable()();
  late final maxresUrl = text().nullable()();

  @override
  get primaryKey => {id};
}

class VideoContentDetails extends Table with TableTimedMixin {
  late final id = text().references(Videos, #id)();
  late final duration = text()();
  late final dimension = text()();
  late final definition = text()();
  late final caption = text()();
  late final licensedContent = boolean()();
  late final projection = text()();

  @override
  get primaryKey => {id};
}

class VideoStatuses extends Table with TableTimedMixin {
  late final id = text().references(Videos, #id)();
  late final uploadStatus = text()();
  late final privacyStatus = text()();
  late final license = text()();
  late final embeddable = boolean()();
  late final publicStatsViewable = boolean()();
  late final madeForKids = boolean()();

  @override
  get primaryKey => {id};
}

class VideoStatistics extends Table with TableTimedMixin {
  late final id = text().references(Videos, #id)();
  late final viewCount = integer()();
  late final likeCount = integer().nullable()();
  late final dislikeCount = integer().nullable()();
  late final favoriteCount = integer()();
  late final commentCount = integer()();

  @override
  get primaryKey => {id};
}

class VideoProgress extends Table with TableTimedMixin {
  late final id = text().references(Videos, #id)();
  late final watchPosition = integer().withDefault(const Constant(0))();
  late final isFinished = boolean().withDefault(const Constant(false))();

  @override
  get primaryKey => {id};
}
