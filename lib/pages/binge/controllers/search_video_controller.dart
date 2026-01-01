import 'dart:async';

import 'package:bingetube/core/db/access/search.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SearchVideoBingeController extends BaseBingeController {
  final int searchId;

  SearchVideoBingeController(
    this.searchId,
    String videoId, {
    required super.initialHeroId,
    required super.initialHeroImg,
  }) {
    super.videoId = videoId;
  }

  @override
  Stream<BingeModel> get dbStream {
    return SearchDao(
      Database(),
    ).streamVideoSearchModel(searchId).map(mapSearchToBingeModel);
  }

  BingeModel mapSearchToBingeModel(VideoSearchModel event) {
    return BingeModel(
      title: event.meta.query,
      description: 'Search results of ${event.meta.query}',
      videos: event.videos,
    );
  }
}
