import 'dart:async';

import 'package:bingetube/core/db/access/search.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SearchVideoBingeController extends BaseBingeController {

  final int searchId;
  late Stream<VideoSearchModel> streamModel;

  SearchVideoBingeController(
    this.searchId,
    String videoId, {
    required super.initialHeroId,
    required super.initialHeroImg,
  }) {
    super.videoId = videoId;
    streamModel = SearchDao(Database()).streamVideoSearchModel(searchId);
  }

  @override
  String get heroImg {
    final activeId = activeVideoId;
    for (var video in bingeModel?.videos ?? []) {
      if (video.video.id == activeId) {
        return video.thumbnails.mediumUrl;
      }
    }
    return super.initialHeroImg;
  }

  @override
  bool get isNextVideoExists {
    final currPos = activeVideoPos;
    if (currPos != null) {
      return currPos != bingeModel!.videos.length - 1;
    }
    return false;
  }

  @override
  bool get isPrevVideoExists {
    final currPos = activeVideoPos;
    if (currPos != null) {
      return currPos != 0;
    }
    return false;
  }

  @override
  Stream<BingeModel> streamBingeModel() {
    return streamModel.map((m) {
      bingeModel = BingeModel(
        title: m.meta.query,
        description: "Videos from the search results of '${m.meta.query}",
        videos: m.videos,
      );
      return bingeModel!;
    });
  }
}
