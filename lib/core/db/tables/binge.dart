import 'package:bingetube/core/db/tables/mixins.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:drift/drift.dart';

class Series extends Table with TableTimedMixin {
  late final id = integer().autoIncrement()();
  late final name = text()();
  late final description = text()();
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
  late final name = text()();
  late final description = text()();
}

class CollectionVsSeries extends Table {
  late final collectionId = integer().references(Collections, #id)();
  late final seriesId = integer().references(Series, #id)();
  late final priority = integer()();

  @override
  get primaryKey => {collectionId, seriesId};
}

class PersonalCollections extends Table with TableTimedMixin {
  late final isSystem = boolean().withDefault(const Constant(false))();
  late final collectionId = integer().references(Collections, #id)();
  late final priority = integer()();

  @override
  get primaryKey => {isSystem, collectionId};
}
