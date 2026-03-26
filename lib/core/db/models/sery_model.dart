import 'package:bingetube/core/db/database.dart';

class SeryModel {
  final Sery sery;
  final VideoThumbnail thumbnail;

  final String? dataPath;
  final String? dataHash;

  SeryModel({
    required this.sery,
    required this.thumbnail,
    this.dataPath,
    this.dataHash,
  });
}
