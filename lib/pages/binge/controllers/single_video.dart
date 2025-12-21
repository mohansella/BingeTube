import 'package:bingetube/core/db/access/videos.dart';
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
  bool get isNextVideoExists => false;

  @override
  bool get isPrevVideoExists => false;

  @override
  String get heroId => initialHeroId;

  @override
  String get heroImg => initialHeroImg;

  @override
  String get title => 'Playing Single Video: $activeVideoId';

  Future<List<VideoModel>>? _videoModelFuture;
  @override
  Future<List<VideoModel>> getAllVideoModels() async {
    if (_videoModelFuture != null) {
      return _videoModelFuture!;
    }
    final videoModel = await videoDao.getVideoModelById(videoId);
    final videoModels = [videoModel];
    _videoModelFuture = Future.value(videoModels);
    return videoModels;
  }
}
