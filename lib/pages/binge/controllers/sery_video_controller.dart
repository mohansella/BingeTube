import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SeryVideoBingeController extends BaseBingeController {
  final int seryId;
  late BingeDao _bingeDao;

  SeryVideoBingeController(
    this.seryId,
    String videoId, {
    required super.initialHeroId,
    required super.initialHeroImg,
  }) {
    super.videoId = videoId;
    _bingeDao = BingeDao(Database());
  }

  @override
  Stream<BingeModel> get dbStream => _bingeDao.streamBingeModel(seryId);

  @override
  List<BingeActions> supportedActions() {
    return [.edit, .moveTo, .duplicate, .delete, .export];
  }

  @override
  Future<Sery?> executeBingeAction(
    BingeActions action, {
    Collection? collection,
    BingeModel? model,
    VideoModel? coverVideo,
  }) async {
    if (action == .delete) {
      await bingeDao.deleteSery(seryId);
      return null;
    }
    if (action == .moveTo) {
      await bingeDao.moveSery(seryId: seryId, collectionId: collection!.id);
      return null;
    }
    if (action == .duplicate) {
      await bingeDao.duplicateSery(seryId, collection!);
      return null;
    }
    if (action == .edit) {
      await bingeDao.editSery(seryId, collection!, model!, coverVideo!);
      return null;
    }
    return super.executeBingeAction(
      action,
      collection: collection,
      model: model,
      coverVideo: coverVideo,
    );
  }
}
