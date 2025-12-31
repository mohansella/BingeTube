import 'dart:async';

import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:drift/drift.dart';

abstract class BaseBingeController implements BingeController {
  static final _logger = LogManager.getLogger('BaseBingeController');

  final String initialHeroId;
  final String initialHeroImg;
  late String videoId;

  BingeModel? unfilteredModel;
  BingeModel? filteredModel;
  BingeFilter bingeFilter = BingeFilter.defaultValue;
  BingeSort bingeSort = BingeSort.defaultValue;

  StreamSubscription? bingeModelSubscriber;
  var streamController = StreamController<BingeModel>();

  final videoDao = VideosDao(Database());

  BaseBingeController({
    required this.initialHeroId,
    required this.initialHeroImg,
  });

  @override
  void dispose() {
    bingeModelSubscriber?.cancel();
    streamController.close();
  }

  @override
  Stream<BingeModel> get stream {
    bingeModelSubscriber ??= dbStream.listen(onModel);
    return streamController.stream;
  }

  Stream<BingeModel> get dbStream;

  @override
  BingeFilter get filter => bingeFilter;

  @override
  void setFilter(BingeFilter filter) {
    bingeFilter = filter;
    emit();
  }

  @override
  BingeSort get sort => bingeSort;

  @override
  void setSort(BingeSort sort) {
    bingeSort = sort;
    emit();
  }

  @override
  String get activeVideoId => videoId;

  @override
  String get heroImg {
    final activeId = activeVideoId;
    for (var video in unfilteredModel?.videos ?? []) {
      if (video.video.id == activeId) {
        return video.thumbnails.mediumUrl;
      }
    }
    return initialHeroImg;
  }

  @override
  String get heroId => initialHeroId;

  @override
  bool get isNextVideoExists {
    final currPos = activeVideoPos;
    if (currPos != null) {
      return currPos != filteredModel!.videos.length - 1;
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
  int? get activeVideoPos {
    if (filteredModel != null) {
      final videos = filteredModel!.videos;
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
  DateTime get minDateTime {
    var model = unfilteredModel!;
    var toReturn = model.videos[0].snippet.publishedAt;
    for (var video in model.videos) {
      if (toReturn.isAfter(video.snippet.publishedAt)) {
        toReturn = video.snippet.publishedAt;
      }
    }
    return toReturn;
  }

  @override
  DateTime get maxDateTime {
    var model = unfilteredModel!;
    var toReturn = model.videos[0].snippet.publishedAt;
    for (var video in model.videos) {
      if (toReturn.isBefore(video.snippet.publishedAt)) {
        toReturn = video.snippet.publishedAt;
      }
    }
    return toReturn;
  }

  @override
  void setPrevVideo() {
    final currPos = activeVideoPos!;
    setActiveVideoId(filteredModel!.videos[currPos - 1].video.id);
  }

  @override
  void setNextVideo() {
    final currPos = activeVideoPos!;
    setActiveVideoId(filteredModel!.videos[currPos + 1].video.id);
  }

  @override
  void setActiveVideoId(String videoId) {
    this.videoId = videoId;
  }

  @override
  void markActiveVideoStarted() {
    final videoId = activeVideoId;
    _logger.info('active videoId:$videoId will be marked as started');
  }

  @override
  void markActiveVideoWatched() {
    final videoId = activeVideoId;
    videoDao.upsertVideoProgress(
      VideoProgressCompanion(
        id: Value(videoId),
        updatedAt: Value(DateTime.now()),
        isFinished: Value(true),
      ),
    );
    _logger.info('active videoId:$videoId marked as watched');
  }

  @override
  Future<VideoModel> getActiveVideoModel() async {
    return videoDao.getVideoModelById(activeVideoId);
  }

  @override
  void setVideoWatched(VideoModel model, bool isFinished) {
    final videoId = model.video.id;
    videoDao.upsertVideoProgress(
      VideoProgressCompanion(
        id: Value(videoId),
        updatedAt: Value(DateTime.now()),
        isFinished: Value(isFinished),
      ),
    );
    _logger.info('videoId:$videoId marked as watched:$isFinished');
  }

  void onModel(BingeModel event) {
    unfilteredModel = event;
    emit();
  }

  void emit() {
    if (unfilteredModel != null) {
      final model = unfilteredModel!;
      final filter = bingeFilter;
      var filtered = model.videos.where((v) => filter.matches(v)).toList();
      if (sort.sortType == .system) {
        if (sort.sortOrder != .asc) {
          filtered = filtered.reversed.toList();
        }
      } else {
        filtered.sort((l, r) => sort.compareModels(l, r));
      }
      filteredModel = BingeModel(
        title: model.title,
        description: model.description,
        videos: filtered,
      );
      streamController.add(filteredModel!);
    }
  }
}
