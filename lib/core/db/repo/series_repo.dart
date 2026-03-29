import 'package:bingetube/core/api/binge_api.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/core/db/port/sery_port.dart';
import 'package:bingetube/core/lang/mutable.dart';
import 'package:bingetube/core/log/log_manager.dart';

class SeriesRepo {
  final bool isSystem;
  final _bingeDao = BingeDao(Database());

  static final _logger = LogManager.getLogger('SeriesRepo');

  SeriesRepo({required this.isSystem});

  Future<Sery?> downloadSery(
    Mutable<bool> isCancelled,
    CollectionModel collection,
    SeryModel model,
  ) async {
    SeriesRepo._logger.info('saving sery:${model.sery.name}');

    final result = await BingeApi.getBingeBlob(model.dataPath!);
    if (result.isError()) {
      throw result.exceptionOrNull()!;
    }
    if (isCancelled.value) {
      SeriesRepo._logger.info('save sery cancelled');
      return null;
    }
    final response = result.getOrThrow();
    final newSery = await SeryPort.import(
      response,
      collectionId: collection.collection.id,
      priority: model.sery.priority,
    );
    SeriesRepo._logger.info('saved sery:${model.sery.name} in id:${newSery.id}');

    await _bingeDao.updateSery(newSery.id, dataHash: model.dataHash);
    return newSery;
  }

  Future<Sery?> updateSery(
    Mutable<bool> isCancelled,
    CollectionModel collection,
    SeryModel model,
  ) async {
    SeriesRepo._logger.info('updating sery:${model.sery.name}');

    final result = await BingeApi.getBingeBlob(model.dataPath!);
    if (result.isError()) {
      throw result.exceptionOrNull()!;
    }
    if (isCancelled.value) {
      SeriesRepo._logger.info('update sery cancelled');
      return null;
    }
    final response = result.getOrThrow();
    final newSery = await SeryPort.import(
      response,
      collectionId: collection.collection.id,
      priority: model.sery.priority,
      seryId: model.sery.id,
    );
    SeriesRepo._logger.info('saved sery:${model.sery.name} in id:${newSery.id}');

    await _bingeDao.updateSery(newSery.id, dataHash: model.dataHash);
    return newSery;
  }
}
