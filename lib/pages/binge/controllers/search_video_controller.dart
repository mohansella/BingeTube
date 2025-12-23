import 'dart:async';

import 'package:bingetube/core/db/access/search.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SearchVideoBingeController extends BaseBingeController {
  static final _logger = LogManager.getLogger('SearchVideoBingeController');

  final int searchId;
  late String videoId;
  late Stream<VideoSearchModel> streamModel;
  VideoSearchModel? model;

  SearchVideoBingeController(
    this.searchId,
    this.videoId, {
    required super.initialHeroId,
    required super.initialHeroImg,
  }) {
    streamModel = SearchDao(Database()).streamVideoSearchModel(searchId);
  }

  int? get activeVideoPos {
    if (model != null) {
      final videos = model!.videos;
      for (int i = 0; i < videos.length; i++) {
        final video = videos[i];
        if (video.video.id == videoId) {
          return i;
        }
      }
    }
    return null;
  }

  @override
  String get activeVideoId => videoId;

  @override
  bool get isNextVideoExists {
    final currPos = activeVideoPos;
    if (currPos != null) {
      return currPos != model!.videos.length - 1;
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

  void onStreamData(VideoSearchModel event) {
    model = event;
  }

  @override
  Stream<BingeModel> streamBingeModel() {
    return streamModel.map((m) {
      _logger.info('mapping SearchVideoModel to BingeModel');
      return BingeModel(
        title: m.meta.query,
        description: "Videos from the search results of '${m.meta.query}",
        videos: m.videos,
      );
    });
  }
}
