import 'dart:async';

import 'package:bingetube/core/api/binge_api.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/core/log/log_manager.dart';

class CollectionsRepo {
  final bool isSystem;
  final BingeDao _bingeDao = BingeDao(Database());

  static final _logger = LogManager.getLogger('CollectionsRepo');

  CollectionsRepo({required this.isSystem});

  Stream<List<CollectionModel>> streamCollections() async* {
    final dbStream = _bingeDao.streamCollectionModels(isSystem: isSystem);
    if (isSystem) {
      final discover = await _getDiscoverCollection();
      await for (final system in dbStream) {
        yield await _mergeDiscoverIntoSystem(system: system, discover: discover);
      }
    } else {
      yield* dbStream;
    }
  }

  Future<List<CollectionModel>> _mergeDiscoverIntoSystem({
    required List<CollectionModel> system,
    required List<CollectionModel> discover,
  }) async {
    await _mergeFirstTime(system: system, discover: discover);
    return discover;
  }

  bool _firstUpdated = false;
  Future<void> _mergeFirstTime({
    required List<CollectionModel> system,
    required List<CollectionModel> discover,
  }) async {
    if (_firstUpdated) {
      return;
    }

    //1. find CUD collections on top of system from discovered
    final allSystem = await _bingeDao.getCollections(isSystem: isSystem);
    final systemMap = Map.fromEntries(allSystem.map((c) => MapEntry(c.name, c)));
    final discoverMap = Map.fromEntries(
      discover.map((c) => MapEntry(c.collection.name, c.collection)),
    );
    _logger.info('system collections: ${allSystem.length}');
    final newCols = {...discoverMap}..removeWhere((k, v) => systemMap.containsKey(k));
    final delCols = {...systemMap}..removeWhere((k, v) => discoverMap.containsKey(k));
    final updCols = {...systemMap}
      ..removeWhere((k, systemCol) {
        if (discoverMap.containsKey(k)) {
          final discoverCol = discoverMap[k]!;
          return systemCol.priority == discoverCol.priority &&
              systemCol.description == discoverCol.description;
        }
        return true;
      });
    _logger.info(
      'discovered collection new:${newCols.keys} delete:${delCols.keys} update:${updCols.keys}',
    );

    //2.apply CU on system
    for (final newCol in newCols.values) {
      await _bingeDao.createCollection(
        priority: newCol.priority,
        name: newCol.name,
        description: newCol.description,
        isSystem: isSystem,
      );
    }
    for (final updCol in updCols.values) {
      final col = discoverMap[updCol.name]!;
      await _bingeDao.updateCollection(
        updCol.id,
        priority: col.priority,
        description: col.description,
      );
    }

    //cleanup
    for (final delCol in delCols.values) {
      await _bingeDao.deleteCollection(delCol.id);
    }
    _firstUpdated = true;
  }

  Future<List<CollectionModel>> _getDiscoverCollection() async {
    final result = await BingeApi.getDiscoverData();
    if (result.isError()) {
      throw Exception(result.exceptionOrNull());
    }
    final response = result.getOrThrow();
    return _parseDiscoverJson(response);
  }

  List<CollectionModel> _parseDiscoverJson(response) {
    final toReturn = <CollectionModel>[];
    final jCollections = response['collections'] as List;

    int collectionPriority = 0;
    final now = DateTime.now();
    for (final jCollection in jCollections) {
      final collectionName = jCollection['name'] as String;
      final seryModels = <SeryModel>[];
      final jSeries = jCollection['series'] as List;
      int seryPriority = 0;
      for (final jSery in jSeries) {
        final title = jSery['title'] as String;
        final description = jSery['description'] as String;

        final jCover = jSery['cover'];
        final coverId = jCover['id'] as String;
        final defaultUrl = jCover['defaultUrl'] as String;
        final mediumUrl = jCover['mediumUrl'] as String;
        final highUrl = jCover['highUrl'] as String;
        final standardUrl = jCover['standardUrl'] as String?;
        final maxresUrl = jCover['maxresUrl'] as String?;

        final dataPath = jSery['dataPath'] as String;
        final dataHash = jSery['dataHash'] as String;

        final sery = Sery(
          createdAt: now,
          updatedAt: now,
          id: -1,
          collectionId: -1,
          coverVideoId: coverId,
          name: title,
          description: description,
          priority: ++seryPriority,
        );

        final thumbnail = VideoThumbnail(
          id: coverId,
          defaultUrl: defaultUrl,
          mediumUrl: mediumUrl,
          highUrl: highUrl,
          standardUrl: standardUrl,
          maxresUrl: maxresUrl,
        );

        final seryModel = SeryModel(
          sery: sery,
          thumbnail: thumbnail,
          dataPath: dataPath,
          dataHash: dataHash,
        );
        seryModels.add(seryModel);

        final collection = Collection(
          createdAt: now,
          updatedAt: now,
          id: -1,
          isSystem: isSystem,
          priority: ++collectionPriority,
          name: collectionName,
          description: '',
        );

        final collectionModel = CollectionModel(
          collection: collection,
          series: seryModels,
        );
        toReturn.add(collectionModel);
      }
    }
    return toReturn;
  }
}
