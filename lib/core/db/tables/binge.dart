import 'package:bingetube/core/db/tables/mixins.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:drift/drift.dart';

class Series extends Table with TableTimedMixin {
  late final id = integer().autoIncrement()();
  late final collectionId = integer().references(Collections, #id)();

  late final name = text()();
  late final description = text()();

  late final priority = integer()();
}

class SeriesVsVideos extends Table {
  late final seriesId = integer().references(Series, #id)();
  late final videoId = text().references(Videos, #id)();
  late final priority = integer()();

  @override
  get primaryKey => {seriesId, videoId};
}

class Collections extends Table with TableTimedMixin {
  late final id = integer().autoIncrement()();
  late final isSystem = boolean()();
  late final priority = integer()();

  late final name = text()();
  late final description = text()();
}
