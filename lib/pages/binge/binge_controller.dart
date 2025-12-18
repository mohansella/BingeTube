import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/pages/binge/controllers/single_video.dart';

enum BingeControllerType {
  singleVideo,
  searchVideos,
  channelVideos,
  playlistVideos,
  myshowSeries,
  systemSeries,
}

enum BingeControllerParam { id, type }

abstract class BingeController {
  String get pageTitle;

  factory BingeController(Map<String, String> params) {
    final id = params[BingeControllerParam.id.name]!;
    final typeValue = params[BingeControllerParam.type.name]!;
    final controllerType = BingeControllerType.values.byName(typeValue);
    switch (controllerType) {
      case .singleVideo:
        return SingleVideoBingeController(id);
      default:
        throw StateError('unimpelemented');
    }
  }

  Future<VideoModel> getActiveVideoModel();
  String get activeVideoId;
  bool get isPrevVideoExists;
  bool get isNextVideoExists;

  void markVideoStarted();
  void markVideoWatched();
}
