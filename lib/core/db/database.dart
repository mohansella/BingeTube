import 'package:bingetube/core/log/log_manager.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logging/logging.dart';

part 'database.g.dart';

@DriftDatabase(tables: [VideoMeta, VideoSnippet, VideoThumbnail])
class Database extends _$Database {
  static final Logger _logger = LogManager.getLogger('Database');

  static final _database = Database._internal();
  factory Database() => _database;
  Database._internal() : super(driftDatabase(name: 'database'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (OpeningDetails openDetails) async {
      await customStatement('PRAGMA foreign_keys = ON');
      _logger.info(
        'opening database version:${openDetails.versionNow} before:${openDetails.versionBefore}',
      );
    },
    onCreate: (Migrator m) async {
      _logger.info('creating tables');
      await m.createAll();
    },
  );
}

@TableIndex(name: 'index_etag', columns: {#etag})
class VideoMeta extends Table {
  TextColumn get id => text()();
  TextColumn get etag => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class VideoSnippet extends Table {
  TextColumn get id => text().references(VideoMeta, #id)();

  DateTimeColumn get publishedAt => dateTime()();
  TextColumn get channelId => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get channelTitle => text()();
  TextColumn get liveBroadcastContent => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class VideoThumbnail extends Table {
  TextColumn get id => text().references(VideoMeta, #id)();

  TextColumn get defaultUrl => text()();
  TextColumn get mediumUrl => text()();
  TextColumn get highUrl => text()();
  TextColumn get standardUrl => text().nullable()();
  TextColumn get maxresUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
