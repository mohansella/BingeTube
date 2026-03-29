import 'package:bingetube/core/db/database.dart';

class SeryModel {
  final Sery sery;
  final VideoThumbnail thumbnail;

  final String? dataPath;
  final String? dataHash;
  final bool isSaved;

  SeryModel({
    required this.sery,
    required this.thumbnail,
    this.dataPath,
    this.dataHash,
    this.isSaved = true,
  });
}
