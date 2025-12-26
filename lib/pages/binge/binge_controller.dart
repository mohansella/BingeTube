import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_filter.dart';
import 'package:bingetube/pages/binge/controllers/search_video_controller.dart';
import 'package:bingetube/pages/binge/controllers/single_video_controller.dart';
import 'package:bingetube/pages/pages.dart';

enum BingeType {
  singleVideo,
  searchVideos,
  channelVideos,
  playlistVideos,
  myshowSeries,
  systemSeries,
}

enum BingeParams { type, id, heroId, heroImg, selectedVideoId }

class BingeModel {
  final String title;
  final String description;
  final List<VideoModel> videos;

  BingeModel({
    required this.title,
    required this.description,
    required this.videos,
  });
}

abstract class BingeController {
  static final _logger = LogManager.getLogger('BingeController');

  void dispose();

  String get activeVideoId;
  Stream<BingeModel> get stream;

  BingeFilter get filter;
  void setFilter(BingeFilter filter);

  String get heroId;
  String get heroImg;

  bool get isPrevVideoExists;
  bool get isNextVideoExists;

  int? get activeVideoPos;

  void setActiveVideoId(String videoId);
  void setPrevVideo();
  void setNextVideo();

  Future<VideoModel> getActiveVideoModel();
  void markVideoStarted();
  void markVideoWatched();

  factory BingeController(Map<String, String> params) {
    final typeValue = params[BingeParams.type.name]!;
    final id = params[BingeParams.id.name]!;
    final heroId = params[BingeParams.heroId.name]!;
    final heroImg = params[BingeParams.heroImg.name]!;
    final selectedVideoId = params[BingeParams.selectedVideoId.name];
    final controllerType = BingeType.values.byName(typeValue);
    switch (controllerType) {
      case .singleVideo:
        return SingleVideoBingeController(
          id,
          initialHeroId: heroId,
          initialHeroImg: heroImg,
        );
      case .searchVideos:
        return SearchVideoBingeController(
          int.parse(id),
          selectedVideoId!,
          initialHeroId: heroId,
          initialHeroImg: heroImg,
        );
      default:
        throw StateError('unimpelemented');
    }
  }

  static String buildPath({
    required BingeType type,
    required String id,
    required String heroId,
    required String heroImg,
    String? selectedVideoId,
  }) {
    final buffer = StringBuffer(Pages.binge.path)
      ..write('?type=${type.name}')
      ..write('&id=$id')
      ..write('&heroId=$heroId')
      ..write('&heroImg=$heroImg');
    if (selectedVideoId != null) {
      buffer.write('&selectedVideoId=$selectedVideoId');
    }
    final toReturn = buffer.toString();
    _logger.info('built path: $toReturn');
    return toReturn;
  }
}
