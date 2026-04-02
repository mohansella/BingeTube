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
    final systemSMap = {for (final s in system.expand((c) => c.series)) s.sery.name: s};
    return discover.map((d) {
      return CollectionModel(
        collection: d.collection,
        series: d.series.map((ds) {
          if (systemSMap.containsKey(ds.sery.name)) {
            final sSery = systemSMap[ds.sery.name]!;
            return SeryModel(
              sery: sSery.sery,
              coverUrl: sSery.coverUrl,
              iconUrl: sSery.iconUrl,
              watchedVideos: sSery.watchedVideos,
              totalVideos: sSery.totalVideos,
              dataPath: ds.dataPath,
              dataHash: ds.dataHash,
            );
          }
          return ds;
        }).toList(),
      );
    }).toList();
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
    final systemMap = {for (final c in allSystem) c.name: c};
    final discoverMap = {for (final c in discover) c.collection.name: c.collection};
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

    //2.apply collection CU operations on system
    for (final newCol in newCols.values) {
      final newSysCol = await _bingeDao.createCollection(
        priority: newCol.priority,
        name: newCol.name,
        description: newCol.description,
        isSystem: isSystem,
      );
      systemMap[newSysCol.name] = newSysCol;
    }
    for (final updCol in updCols.values) {
      final col = discoverMap[updCol.name]!;
      await _bingeDao.updateCollection(
        updCol.id,
        priority: col.priority,
        description: col.description,
      );
    }

    //3. move collection to user's default collection
    final systemSMap = {
      for (final s in system.expand((c) => c.series)) s.sery.dataPath!: s,
    };
    final discoverSMap = {
      for (final s in discover.expand((c) => c.series)) s.dataPath!: s,
    };
    final newSeries = {...discoverSMap}..removeWhere((k, s) => systemSMap.containsKey(k));
    final delSeries = {...systemSMap}..removeWhere((k, s) => discoverSMap.containsKey(k));
    _logger.info('discovered series new_count:${newSeries.length} del:${delSeries.keys}');
    final defColId = await _bingeDao.getDefaultCollection();
    for (final delSery in delSeries.values) {
      await _bingeDao.updateSery(delSery.sery.id, collectionId: defColId.id);
    }

    //4. find series need update
    final disColIdVsName = {for (final c in discover) c.collection.id: c.collection.name};
    final updSeryIdVsColId = <int, int>{};
    final updSeries = {...systemSMap}
      ..removeWhere((k, sysSeries) {
        if (discoverSMap.containsKey(k)) {
          final disSeries = discoverSMap[k]!;
          final disColName = disColIdVsName[disSeries.sery.collectionId]!;
          final sysCol = systemMap[disColName]!;
          if (sysSeries.sery.collectionId != sysCol.id) {
            _logger.info('series:$k collection name updated to $disColName');
            updSeryIdVsColId[sysSeries.sery.id] = sysCol.id;
            return false;
          }
          final disSery = disSeries.sery;
          final sysSery = sysSeries.sery;
          return sysSery.description == disSery.description &&
              sysSery.priority == sysSery.priority;
        }
        return true;
      });
    _logger.info('series: ${updSeries.keys} needs update');
    for (final entry in updSeryIdVsColId.entries) {
      await _bingeDao.updateSery(entry.key, collectionId: entry.value);
    }
    for (final updSery in updSeries.values) {
      final disSery = discoverSMap[updSery.sery.dataPath!]!;
      await _bingeDao.updateSery(
        updSery.sery.id,
        description: disSery.sery.description,
        priority: disSery.sery.priority,
      );
    }

    //4. delete collections
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

    int currCollectionId = 0;
    int currCollectionPriority = 0;
    int currSeriesId = 0;
    int currSeriesPriority = 0;
    final now = DateTime.now();
    for (final jCollection in jCollections) {
      currCollectionId++;
      currCollectionPriority++;
      currSeriesPriority = 0;

      final collectionName = jCollection['name'] as String;
      final collection = Collection(
        createdAt: now,
        updatedAt: now,
        id: currCollectionId,
        isSystem: isSystem,
        priority: currCollectionPriority,
        name: collectionName,
        description: '',
      );

      final seryModels = <SeryModel>[];
      final jSeries = jCollection['series'] as List;

      for (final jSery in jSeries) {
        currSeriesId++;
        currSeriesPriority++;
        final title = jSery['title'] as String;
        final description = jSery['description'] as String;
        final coverUrl = jSery['coverUrl'] as String;
        final iconUrl = jSery['iconUrl'] as String;
        final totalVideos = jSery['totalVideos'] as int;
        final dataPath = jSery['dataPath'] as String;
        final dataHash = jSery['dataHash'] as String;

        final sery = Sery(
          createdAt: now,
          updatedAt: now,
          id: currSeriesId,
          collectionId: currCollectionId,
          coverVideoId: 'coverVideoId',
          name: title,
          description: description,
          priority: currSeriesPriority,
        );

        final seryModel = SeryModel(
          sery: sery,
          coverUrl: coverUrl,
          iconUrl: iconUrl,
          watchedVideos: 0,
          totalVideos: totalVideos,
          dataPath: dataPath,
          dataHash: dataHash,
          isSaved: false,
        );
        seryModels.add(seryModel);
      }

      final collectionModel = CollectionModel(collection: collection, series: seryModels);
      toReturn.add(collectionModel);
    }
    return toReturn;
  }
}
