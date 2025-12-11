import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:drift/drift.dart';

part '../../../generated/core/db/access/videos.g.dart';

class VideoModel {
  final Videos video;
  final VideoSnippets snippet;
  final VideoThumbnails thumbnails;
  final VideoContentDetails contentDetails;
  final VideoStatuses status;
  final VideoStatistics statistics;
  final VideoProgress progress;

  VideoModel({
    required this.video,
    required this.snippet,
    required this.thumbnails,
    required this.contentDetails,
    required this.status,
    required this.statistics,
    required this.progress,
  });
}

@DriftAccessor(
  tables: [
    Videos,
    VideoSnippets,
    VideoThumbnails,
    VideoContentDetails,
    VideoStatuses,
    VideoStatistics,
    VideoProgress,
  ],
)

class VideosDao extends DatabaseAccessor<Database> with _$VideosDaoMixin {
  VideosDao(super.attachedDatabase);
}
