import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SingleVideoBingeController extends BaseBingeController {
  final String videoId;

  SingleVideoBingeController(
    this.videoId, {
    required super.initialHeroId,
    required super.initialHeroImg,
  });

  @override
  String get activeVideoId => videoId;

  @override
  Stream<BingeModel> streamBingeModel() {
    final videoModel = videoDao.getVideoModelById(videoId);
    return Stream.fromFuture(videoModel).map((m) {
      return BingeModel(
        title: m.snippet.title,
        description: m.snippet.description,
        videos: [m],
      );
    }).asBroadcastStream();
  }
}
