import 'package:bingetube/core/db/models/video_model.dart';

class BingeModel {
  final String title;
  final String description;
  final List<VideoModel> videos;

  BingeModel({
    required this.title,
    required this.description,
    required this.videos,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'videos': videos.map((v) => v.toJson()).toList(),
    };
  }

  factory BingeModel.fromJson(Map<String, dynamic> json) {
    return BingeModel(
      title: json['title'] as String,
      description: json['description'] as String,
      videos: (json['videos'] as List<dynamic>)
          .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
