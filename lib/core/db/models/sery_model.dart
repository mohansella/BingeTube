import 'package:bingetube/core/db/database.dart';

class SeryModel {
  final Sery sery;
  final String coverUrl;
  final String iconUrl;
  final int totalVideos;
  final int watchedVideos;

  final String? dataPath;
  final String? dataHash;
  final bool isSaved;

  SeryModel({
    required this.sery,
    required this.coverUrl,
    required this.iconUrl,
    required this.totalVideos,
    required this.watchedVideos,
    this.dataPath,
    this.dataHash,
    this.isSaved = true,
  });
}
