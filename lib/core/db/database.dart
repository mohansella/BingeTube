import 'package:bingetube/core/db/database.steps.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logging/logging.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/db/tables/channels.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:bingetube/core/db/tables/playlists.dart';
import 'package:bingetube/core/db/tables/search.dart';
import 'package:bingetube/core/db/tables/binge.dart';
import 'package:bingetube/core/db/access/channels.dart';

part '../../generated/core/db/database.g.dart';

@DriftDatabase(
  tables: [
    //channels
    Channels,
    ChannelSnippets,
    ChannelThumbnails,
    ChannelContentDetails,
    ChannelStatistics,
    ChannelStatuses,

    //videos
    Videos,
    VideoSnippets,
    VideoThumbnails,
    VideoContentDetails,
    VideoStatuses,
    VideoStatistics,
    VideoProgress,

    //playlist
    Playlists,
    PlaylistSnippets,
    PlaylistThumbnails,
    PlaylistContentDetails,
    PlaylistVsVideos,

    //search
    ChannelSearches,
    ChannelSearchVsChannels,
    VideoSearches,
    VideoSearchVsVideos,

    //binge
    Series,
    SeriesVsVideos,
    Collections,
  ],
  daos: [ChannelsDao],
)
class Database extends _$Database {
  static final Logger _logger = LogManager.getLogger('Database');

  static final _database = Database._internal();

  factory Database([QueryExecutor? e]) {
    if (e == null) {
      return _database;
    }
    return Database._internal(e);
  }

  Database._internal([QueryExecutor? e]) : super(e ?? _openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: _listenOpen,
    onCreate: _listenFirstTimeOpen,
    onUpgrade: stepByStep(from1To2: _from1To2, from2To3: _from2To3),
  );

  Future<void> _listenFirstTimeOpen(Migrator m) async {
    _logger.info('creating tables');
    await m.createAll();
  }

  Future<void> _listenOpen(OpeningDetails openDetails) async {
    await customStatement('PRAGMA foreign_keys = ON');
    _logger.info(
      'opened database. version:${openDetails.versionNow} before:${openDetails.versionBefore}',
    );
  }

  Future<void> _from1To2(Migrator m, Schema2 schema) async {
    _logger.info('migrating database from 1 to 2');
    await m.addColumn(schema.series, schema.series.dataHash);
    _logger.info('migrated database from 1 to 2');
  }

  Future<void> _from2To3(Migrator m, Schema3 schema) async {
    _logger.info('migrating database from 2 to 3');
    final tables = <TableInfo<Table, dynamic>>[
      schema.channelSnippets,
      schema.channelThumbnails,
      schema.channelContentDetails,
      schema.channelStatistics,
      schema.channelStatuses,
      schema.videoSnippets,
      schema.videoThumbnails,
      schema.videoContentDetails,
      schema.videoStatuses,
      schema.videoStatistics,
      schema.videoProgress,
      schema.playlists,
      schema.playlistSnippets,
      schema.playlistThumbnails,
      schema.playlistContentDetails,
      schema.playlistVsVideos,
      schema.channelSearchVsChannels,
      schema.videoSearchVsVideos,
      schema.series,
      schema.seriesVsVideos,
    ];
    for (final table in tables) {
      await m.alterTable(TableMigration(table));
    }
    _logger.info('migrated database from 2 to 3');
  }
}
