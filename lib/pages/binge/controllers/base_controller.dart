import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';

abstract class BaseBingeController implements BingeController {
  static final _logger = LogManager.getLogger('BaseBingeController');

  final videoDao = VideosDao(Database());

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
