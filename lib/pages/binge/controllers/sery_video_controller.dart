import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
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
}
