import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/controllers/single_video_controller.dart';
import 'package:bingetube/pages/pages.dart';

enum BingeControllerType {
  singleVideo,
  searchVideos,
  channelVideos,
  playlistVideos,
  myshowSeries,
  systemSeries,
}

enum BingeControllerParam { type, id, heroId, heroImg }

abstract class BingeController {
  static final _logger = LogManager.getLogger('BingeController');

  String get title;
  String get activeVideoId;

  String get heroId;
  String get heroImg;

  bool get isPrevVideoExists;
  bool get isNextVideoExists;

  Future<VideoModel> getActiveVideoModel();
  Stream<List<VideoModel>> streamAllVideoModels();

  void markVideoStarted();
  void markVideoWatched();

  factory BingeController(Map<String, String> params) {
    final typeValue = params[BingeControllerParam.type.name]!;
    final id = params[BingeControllerParam.id.name]!;
    final heroId = params[BingeControllerParam.heroId.name]!;
    final heroImg = params[BingeControllerParam.heroImg.name]!;
    final controllerType = BingeControllerType.values.byName(typeValue);
    switch (controllerType) {
      case .singleVideo:
        return SingleVideoBingeController(
          id,
          initialHeroId: heroId,
          initialHeroImg: heroImg,
        );
      default:
        throw StateError('unimpelemented');
    }
  }

  static String buildPath({
    required BingeControllerType type,
    required String id,
    required String heroId,
    required String heroImg,
  }) {
    final buffer = StringBuffer(Pages.binge.path)
      ..write('?type=${type.name}')
      ..write('&id=$id')
      ..write('&heroId=$heroId')
      ..write('&heroImg=$heroImg');
    final toReturn = buffer.toString();
    _logger.info('built path: $toReturn');
    return toReturn;
  }
}
