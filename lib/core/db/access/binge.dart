import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:bingetube/core/db/tables/binge.dart';
import 'package:bingetube/core/db/tables/channels.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/binge.g.dart';

@DriftAccessor(
  tables: [
    Collections,
    Series,
    SeriesVsVideos,
    Videos,
    VideoThumbnails,
    VideoProgress,
    Channels,
    ChannelThumbnails,
  ],
)
class BingeDao extends DatabaseAccessor<Database> with _$BingeDaoMixin {
  static final _logger = LogManager.getLogger('BingeDao');

  BingeDao(super.attachedDatabase);

  Future<Collection> getDefaultCollection() async {
    final query = select(collections)
      ..where((c) => c.isSystem.equals(false))
      ..orderBy([(c) => OrderingTerm.asc(c.createdAt)])
      ..limit(1);
    var result = await query.get();
    if (result.isEmpty) {
      _logger.info('User Binge collection is empty. so will create one');
      await createCollection(
        name: 'Default Collection',
        description: 'Default collection created by system',
        isSystem: false,
      );
      result = await query.get();
    }
    return result[0];
  }

  Future<Collection> createCollection({
    required String name,
    required String description,
    required bool isSystem,
    int priority = 0,
  }) async {
    final rowId = await into(collections).insert(
      CollectionsCompanion.insert(
        priority: priority,
        name: name,
        description: description,
        isSystem: isSystem,
      ),
    );
    final query = select(collections)..where((c) => c.id.equals(rowId));
    return query.getSingle();
  }

  Future<void> updateCollection(
    int collectionId, {
    required int priority,
    required String description,
  }) async {
    final query = update(collections)..where((c) => c.id.equals(collectionId));
    await query.write(
      CollectionsCompanion(priority: Value(priority), description: Value(description)),
    );
  }

  Future<void> deleteCollection(int collectionId) async {
    final query = delete(collections)..where((c) => c.id.equals(collectionId));
    await query.go();
  }

  Future<List<Collection>> getCollections({bool isSystem = false}) {
    final query = select(collections)
      ..where((c) => c.isSystem.equals(isSystem))
      ..orderBy([(c) => OrderingTerm.asc(c.createdAt)]);
    return query.get();
  }

  Stream<List<CollectionModel>> streamCollectionModels({bool isSystem = false}) {
    final colTotalCount = countAll();
    final colCompleteCount = countAll(filter: videoProgress.isFinished.equals(true));
    final query =
        select(collections).join([
            innerJoin(series, series.collectionId.equalsExp(collections.id)),
            innerJoin(videos, videos.id.equalsExp(series.coverVideoId)),
            innerJoin(videoThumbnails, videoThumbnails.id.equalsExp(series.coverVideoId)),
            innerJoin(
              channelThumbnails,
              channelThumbnails.id.equalsExp(videos.channelId),
            ),
            leftOuterJoin(seriesVsVideos, seriesVsVideos.seriesId.equalsExp(series.id)),
            leftOuterJoin(
              videoProgress,
              videoProgress.id.equalsExp(seriesVsVideos.videoId),
            ),
          ])
          ..groupBy([seriesVsVideos.seriesId])
          ..addColumns([colTotalCount, colCompleteCount])
          ..where(collections.isSystem.equals(isSystem));
    final toReturn = query.watch().map((result) {
      Map<int, Collection> idVsCollection = {};
      Map<int, List<SeryModel>> idVsSeries = {};
      for (var row in result) {
        final collection = row.readTable(collections);
        final sery = row.readTable(series);
        final coverUrl = row.readTable(videoThumbnails).mediumUrl;
        final iconUrl = row.readTable(channelThumbnails).defaultUrl;
        final totalVideos = row.read(colTotalCount)!;
        final completeVideos = row.read(colCompleteCount)!;
        idVsCollection[collection.id] = collection;
        idVsSeries
            .putIfAbsent(collection.id, () => <SeryModel>[])
            .add(
              SeryModel(
                sery: sery,
                coverUrl: coverUrl,
                iconUrl: iconUrl,
                totalVideos: totalVideos,
                watchedVideos: completeVideos,
              ),
            );
      }
      for (final seryies in idVsSeries.values) {
        seryies.sort((a, b) => a.sery.priority - b.sery.priority);
      }
      final models = idVsCollection.values
          .map((c) => CollectionModel(collection: c, series: idVsSeries[c.id]!))
          .toList();
      models.sort((a, b) => a.collection.priority - b.collection.priority);
      return models;
    });
    return toReturn;
  }

  Future<Sery> importBingeModel(
    BingeModel model, {
    required int collectionId,
    required String coverId,
    required int priority,
    int? seryId,
  }) async {
    final sery = await saveBingeModel(
      model,
      collectionId: collectionId,
      coverVideoId: coverId,
      seryId: seryId,
    );
    await shiftSery(seryId: sery.id, collectionId: collectionId, priority: priority);
    return sery;
  }

  Future<Sery> saveBingeModel(
    BingeModel model, {
    required int collectionId,
    required String coverVideoId,
    int? seryId,
  }) async {
    return await transaction(() async {
      if (seryId != null) {
        await deleteSery(seryId);
      }
      final seriesId = await into(series).insert(
        SeriesCompanion.insert(
          id: seryId == null ? Value.absent() : Value(seryId),
          collectionId: collectionId,
          coverVideoId: coverVideoId,
          name: model.title,
          description: model.description,
          priority: 0,
        ),
      );
      for (var i = 0; i < model.videos.length; i++) {
        await into(seriesVsVideos).insert(
          SeriesVsVideosCompanion.insert(
            seriesId: seriesId,
            videoId: model.videos[i].video.id,
            priority: i + 1,
          ),
        );
      }
      final query = select(series)..where((s) => s.id.equals(seriesId));
      return await query.getSingle();
    });
  }

  Stream<BingeModel> streamBingeModel(int seryId) {
    final baseQuery = select(series).join([
      innerJoin(seriesVsVideos, seriesVsVideos.seriesId.equalsExp(series.id)),
      innerJoin(videos, videos.id.equalsExp(seriesVsVideos.videoId)),
    ])..where(series.id.equals(seryId));
    baseQuery.orderBy([OrderingTerm.asc(seriesVsVideos.priority)]);
    final videosDao = VideosDao(attachedDatabase);
    final fullQuery = videosDao.joinVideoAndChannelTables(selectStatement: baseQuery);
    return fullQuery.watch().map((result) {
      if (result.isEmpty) {
        return BingeModel(title: '', description: '', videos: []);
      }
      final sery = result[0].readTable(series);
      final videos = result.map(videosDao.mapRowToModel).toList();
      return BingeModel(title: sery.name, description: sery.description, videos: videos);
    });
  }

  Future<void> deleteSery(int seryId) async {
    await transaction(() async {
      final deleteMap = delete(seriesVsVideos)..where((sv) => sv.seriesId.equals(seryId));
      await deleteMap.go();
      final deleteSery = delete(series)..where((s) => s.id.equals(seryId));
      await deleteSery.go();
    });
  }

  Future<void> shiftSery({
    required int seryId,
    required int collectionId,
    int priority = 1,
  }) async {
    await transaction(() async {
      final seriesQuery = select(series)
        ..where((s) => series.collectionId.equals(collectionId))
        ..where((s) => s.priority.isBiggerOrEqualValue(priority))
        ..orderBy([(s) => OrderingTerm.asc(s.priority)]);
      final seryies = await seriesQuery.get();
      var newPriority = priority;
      for (final sery in seryies) {
        if (sery.id == seryId) {
          return;
        }
        final updateQuery = update(series)..where((s) => s.id.equals(sery.id));
        await updateQuery.write(
          SeriesCompanion(
            id: Value(sery.id),
            collectionId: Value(sery.collectionId),
            priority: Value(++newPriority),
          ),
        );
      }

      final query = update(series)..where((s) => s.id.equals(seryId));
      await query.write(
        SeriesCompanion(
          id: Value(seryId),
          collectionId: Value(collectionId),
          priority: Value(priority),
        ),
      );
    });
  }

  Future<void> duplicateSery(int seryId, int collectionId) async {
    final model = await streamBingeModel(seryId).first;
    await saveBingeModel(
      model,
      collectionId: collectionId,
      coverVideoId: model.videos[0].video.id,
    );
  }

  Future<Sery> editSery(
    int seryId,
    Collection collection,
    BingeModel model,
    VideoModel coverVideo,
  ) async {
    return await transaction(() async {
      final deleteMap = delete(seriesVsVideos)..where((sv) => sv.seriesId.equals(seryId));
      await deleteMap.go();
      final writeQuery = update(series)..where((s) => s.id.equals(seryId));
      await writeQuery.write(
        SeriesCompanion.insert(
          id: Value(seryId),
          collectionId: collection.id,
          coverVideoId: coverVideo.video.id,
          name: model.title,
          description: model.description,
          priority: 0,
          updatedAt: Value(DateTime.now()),
        ),
      );
      for (var i = 0; i < model.videos.length; i++) {
        await into(seriesVsVideos).insert(
          SeriesVsVideosCompanion.insert(
            seriesId: seryId,
            videoId: model.videos[i].video.id,
            priority: i + 1,
          ),
        );
      }
      final query = select(series)..where((s) => s.id.equals(seryId));
      return await query.getSingle();
    });
  }

  Future<void> updateSery(
    int seryId, {
    String? coverId,
    String? description,
    String? dataPath,
    String? dataHash,
    int? priority,
    int? collectionId,
  }) async {
    final comp = SeriesCompanion(
      id: Value(seryId),
      coverVideoId: coverId == null ? Value.absent() : Value(coverId),
      description: description == null ? Value.absent() : Value(description),
      priority: priority == null ? Value.absent() : Value(priority),
      collectionId: collectionId == null ? Value.absent() : Value(collectionId),
      dataPath: dataPath == null ? Value.absent() : Value(dataPath),
      dataHash: dataHash == null ? Value.absent() : Value(dataHash),
    );
    final query = update(series)..where((s) => s.id.equals(seryId));
    await query.write(comp);
  }

  Future<Sery> getSery(int seryId) async {
    final query = select(series).join([
      innerJoin(collections, collections.id.equalsExp(series.collectionId)),
    ])..where(series.id.equals(seryId));
    final result = await query.getSingle();
    return result.readTable(series);
  }

  Future<List<Sery>> getSeries({required bool isSystem}) async {
    final query = select(series).join([
      innerJoin(collections, collections.id.equalsExp(series.collectionId)),
    ])..where(collections.isSystem.equals(isSystem));
    final result = await query.get();
    return result.map((r) => r.readTable(series)).toList();
  }

  Future<bool> isSystemSery(int seryId) async {
    final query =
        select(
            series,
          ).join([innerJoin(collections, collections.id.equalsExp(series.collectionId))])
          ..where(collections.isSystem.equals(true))
          ..where(series.id.equals(seryId));
    final result = await query.get();
    return result.isNotEmpty;
  }

  Future<void> addVideos(int seryId, List<String> videoIds, int fromPriority) async {
    await transaction(() async {
      for (var i = 0; i < videoIds.length; i++) {
        await into(seriesVsVideos).insert(
          SeriesVsVideosCompanion.insert(
            seriesId: seryId,
            videoId: videoIds[i],
            priority: ++fromPriority,
          ),
        );
      }
    });
  }

  Future<int> getVideosCount(int seryId) async {
    final query = selectOnly(seriesVsVideos)
      ..addColumns([seriesVsVideos.videoId.count()])
      ..where(seriesVsVideos.seriesId.equals(seryId));

    final result = await query.map((row) {
      return row.read(seriesVsVideos.videoId.count())!;
    }).getSingle();

    return result;
  }
}
