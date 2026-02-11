import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SingleVideoBingeController extends BaseBingeController {
  SingleVideoBingeController(
    String id,
    String videoId, {
    required super.initialHeroId,
    required super.initialHeroImg,
  }) {
    if (id != videoId) {
      throw StateError(
        'SingelVideoBingeController expects id:$id and videoId:$videoId to be same',
      );
    }
    super.videoId = videoId;
  }

  @override
  void setActiveVideoId(String videoId) {
    if (this.videoId != videoId) {
      throw StateError(
        'SingelVideoBingeController.setActiveVideoId received $videoId instead of singleton ${this.videoId}',
      );
    }
    super.setActiveVideoId(videoId);
  }

  @override
  Stream<BingeModel> get dbStream {
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
