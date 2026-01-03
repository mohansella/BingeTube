import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/binge.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/binge.g.dart';

@DriftAccessor(tables: [Series, SeriesVsVideos, Collections])
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

  Future<Sery> saveBingeModel(Collection collection, BingeModel model) async {
    return await transaction(() async {
      final seriesId = await into(series).insert(
        SeriesCompanion.insert(
          collectionId: collection.id,
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
}
