import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/binge.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/binge.g.dart';

class CollectionModel {
  final Collection collection;
  final List<SeryModel> series;

  CollectionModel({required this.collection, required this.series});
}

class SeryModel {
  final Sery sery;
  final VideoThumbnail thumbnail;

  SeryModel({required this.sery, required this.thumbnail});
}

@DriftAccessor(
  tables: [Collections, Series, SeriesVsVideos, VideoThumbnails, Videos],
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
        'Default Collection',
        'Default collection created by system',
        false,
      );
      result = await query.get();
    }
    return result[0];
  }

  Future<Collection> createCollection(
    String name,
    String description,
    bool isSystem,
  ) async {
    final rowId = await into(collections).insert(
      CollectionsCompanion.insert(
        priority: 0,
        name: name,
        description: description,
        isSystem: isSystem,
      ),
    );
    final query = select(collections)..where((c) => c.id.equals(rowId));
    return query.getSingle();
  }

  Future<List<Collection>> getCollections({bool isSystem = false}) {
    final query = select(collections)
      ..where((c) => c.isSystem.equals(isSystem))
      ..orderBy([(c) => OrderingTerm.asc(c.createdAt)]);
    return query.get();
  }

  Stream<List<CollectionModel>> streamCollectionModels({
    bool isSystem = false,
  }) {
    final query = select(collections).join([
      innerJoin(series, series.collectionId.equalsExp(collections.id)),
      innerJoin(
        videoThumbnails,
        videoThumbnails.id.equalsExp(series.coverVideoId),
      ),
    ])..where(collections.isSystem.equals(isSystem));
    final toReturn = query.watch().map((result) {
      Map<int, Collection> idVsCollection = {};
      Map<int, List<SeryModel>> idVsSeries = {};
      for (var row in result) {
        final collection = row.readTable(collections);
        final sery = row.readTable(series);
        final thumbnail = row.readTable(videoThumbnails);
        idVsCollection[collection.id] = collection;
        idVsSeries
            .putIfAbsent(collection.id, () => <SeryModel>[])
            .add(SeryModel(sery: sery, thumbnail: thumbnail));
      }
      final models = idVsCollection.values
          .map((c) => CollectionModel(collection: c, series: idVsSeries[c.id]!))
          .toList();
      models.sort((a, b) => a.collection.priority - b.collection.priority);
      return models;
    });
    return toReturn;
  }

  Future<Sery> saveBingeModel(
    Collection collection,
    BingeModel model,
    VideoModel video,
  ) async {
    return await transaction(() async {
      final seriesId = await into(series).insert(
        SeriesCompanion.insert(
          collectionId: collection.id,
          coverVideoId: video.video.id,
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
    final videosDao = VideosDao(attachedDatabase);
    final fullQuery = videosDao.joinVideoAndChannelTables(
      selectStatement: baseQuery,
    );
    return fullQuery.watch().map((result) {
      final sery = result[0].readTable(series);
      final videos = result.map(videosDao.mapRowToModel).toList();
      return BingeModel(
        title: sery.name,
        description: sery.description,
        videos: videos,
      );
    });
  }

  Future<void> deleteSery(int seryId) async {
    await transaction(() async {
      final deleteMap = delete(seriesVsVideos)
        ..where((sv) => sv.seriesId.equals(seryId));
      await deleteMap.go();
      final deleteSery = delete(series)..where((s) => s.id.equals(seryId));
      await deleteSery.go();
    });
  }

  Future<void> moveSery(int seryId, Collection collection) async {
    final query = update(series)..where((s) => s.id.equals(seryId));
    await query.write(
      SeriesCompanion(
        updatedAt: Value(DateTime.now()),
        id: Value(seryId),
        collectionId: Value(collection.id),
      ),
    );
  }
}
