import 'package:bingetube/core/db/models/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/core/db/models/binge_model.freezed.dart';

@freezed
abstract class BingeModel with _$BingeModel {
  const BingeModel._();

  const factory BingeModel({
    required String title,
    required String description,
    required List<VideoModel> videos,
    int? priority,
    int? collectionId,
  }) = _BingeModel;

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
