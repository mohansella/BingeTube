import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/tables/binge.dart';
import 'package:bingetube/core/db/tables/channels.dart';
import 'package:bingetube/core/db/tables/search.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logging/logging.dart';

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

    //search
    ChannelSearches,
    ChannelSearchVsChannels,
    VideoSearches,
    VideoSearchVsVideos,

    //binge
    Series,
    SeriesVsVideos,
    Collections,
    CollectionVsSeries,
    PersonalCollections,
  ],
  daos: [ChannelsDao],
)
class Database extends _$Database {
  static final Logger _logger = LogManager.getLogger('Database');

  static final _database = Database._internal();
  factory Database() => _database;
  Database._internal()
    : super(
        driftDatabase(
          name: 'database',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: listenOpen, onCreate: listenFirstTimeOpen);

  Future<void> listenFirstTimeOpen(Migrator m) async {
    _logger.info('creating tables');
    await m.createAll();
  }

  Future<void> listenOpen(OpeningDetails openDetails) async {
    await customStatement('PRAGMA foreign_keys = ON');
    _logger.info(
      'opened database. version:${openDetails.versionNow} before:${openDetails.versionBefore}',
    );
  }
}
