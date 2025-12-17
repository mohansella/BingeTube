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

  String get activeVideoId;
}

