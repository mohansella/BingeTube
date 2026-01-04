import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/pages/binge/controllers/search_video_controller.dart';
import 'package:bingetube/pages/binge/controllers/sery_video_controller.dart';
import 'package:bingetube/pages/binge/controllers/single_video_controller.dart';

enum BingeType { singleVideo, searchVideos, channelVideos, seryVideos }

enum BingeParams { type, id, heroId, heroImg, videoId }

enum BingeActions { add, edit, moveTo, duplicate, delete }

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
  void dispose();

  String get activeVideoId;
  Stream<BingeModel> get stream;

  BingeFilter get filter;
  void setFilter(BingeFilter filter);

  BingeSort get sort;
  void setSort(BingeSort sort);

  String get heroId;
  String get heroImg;

  bool get isPrevVideoExists;
  bool get isNextVideoExists;

  int? get activeVideoPos;

  DateTime get minDateTime;
  DateTime get maxDateTime;

  void setActiveVideoId(String videoId);
  void setPrevVideo();
  void setNextVideo();

  Future<VideoModel> getActiveVideoModel();
  void markActiveVideoStarted();
  void markActiveVideoWatched();

  void setVideoWatched(VideoModel model, bool isFinished);

  List<BingeActions> supportedActions();
  Future<Sery?> executeBingeAction(
    BingeActions action, {
    Collection? collection,
    BingeModel? model,
    VideoModel? coverVideo,
  });

  factory BingeController(Map<String, String> params) {
    final typeValue = params[BingeParams.type.name]!;
    final id = params[BingeParams.id.name]!;
    final videoId = params[BingeParams.videoId.name] ?? '';
    final heroId = params[BingeParams.heroId.name] ?? '';
    final heroImg = params[BingeParams.heroImg.name] ?? '';
    final controllerType = BingeType.values.byName(typeValue);
    switch (controllerType) {
      case .singleVideo:
        return SingleVideoBingeController(
          id,
          videoId,
          initialHeroId: heroId,
          initialHeroImg: heroImg,
        );
      case .searchVideos:
        return SearchVideoBingeController(
          int.parse(id),
          videoId,
          initialHeroId: heroId,
          initialHeroImg: heroImg,
        );
      case .seryVideos:
        return SeryVideoBingeController(
          int.parse(id),
          videoId,
          initialHeroId: videoId,
          initialHeroImg: heroImg,
        );
      default:
        throw StateError('unimpelemented');
    }
  }

  static Map<String, String> updateParams({
    Map<String, String> baseParams = const {},
    BingeType? type,
    String? id,
    String? videoId,
    String? heroId,
    String? heroImg,
  }) {
    Map<BingeParams, String?> paramVsNullable = {
      .type: type?.name,
      .id: id,
      .videoId: videoId,
      .heroId: heroId,
      .heroImg: heroImg,
    };
    Map<BingeParams, String> paramVsValue = {};
    paramVsNullable.forEach((k, v) {
      if (v != null) {
        paramVsValue[k] = v;
      }
    });
    final toReturn = {...baseParams};
    toReturn.addAll(paramVsValue.map((k, v) => MapEntry(k.name, v)));
    return toReturn;
  }
}
