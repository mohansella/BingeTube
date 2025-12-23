import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';

abstract class BaseBingeController implements BingeController {
  static final _logger = LogManager.getLogger('BaseBingeController');

  final String initialHeroId;
  final String initialHeroImg;
  late String videoId;

  BingeModel? bingeModel;

  final videoDao = VideosDao(Database());

  BaseBingeController({
    required this.initialHeroId,
    required this.initialHeroImg,
  });

  @override
  bool get isNextVideoExists => false;

  @override
  bool get isPrevVideoExists => false;

  @override
  String get heroId => activeVideoId;

  @override
  String get heroImg => initialHeroImg;

  @override
  String get activeVideoId => videoId;

  @override
  void setPrevVideo() {
    // TODO: implement setPrevVideo
  }

  @override
  void setNextVideo() {
    // TODO: implement setNextVideo
  }

  @override
  void setActiveVideoId(String videoId) {
    this.videoId = videoId;
  }

  @override
  void markVideoStarted() {
    final videoId = activeVideoId;
    _logger.info('videoId:$videoId marked as started');
  }

  @override
  void markVideoWatched() {
    final videoId = activeVideoId;
    _logger.info('videoId:$videoId marked as watched');
  }

  @override
  Future<VideoModel> getActiveVideoModel() async {
    return videoDao.getVideoModelById(activeVideoId);
  }
}
