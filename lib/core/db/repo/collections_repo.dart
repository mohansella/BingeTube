import 'dart:async';

import 'package:bingetube/core/api/binge_api.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';

class CollectionsRepo {
  final bool isSystem;
  final BingeDao _bingeDao = BingeDao(Database());

  CollectionsRepo({required this.isSystem});

  Stream<List<CollectionModel>> streamCollections() async* {
    if (isSystem) {
      yield await _getDiscoverCollection();
      await Future.delayed(Duration(days: 3650));
    } else {
      yield* _bingeDao.streamCollectionModels();
    }
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
