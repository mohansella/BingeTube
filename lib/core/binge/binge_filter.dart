import 'package:bingetube/core/db/access/videos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/core/binge/binge_filter.freezed.dart';

enum BingeFilterWatchType {
  all('All'),
  watched('Watched'),
  unwatched('Unwatched');

  final String lable;

  const BingeFilterWatchType(this.lable);
}

@freezed
abstract class BingeFilter with _$BingeFilter {
  const BingeFilter._();

  const factory BingeFilter({
    required BingeFilterWatchType watchType,
    required DateTime? fromRange,
    required DateTime? toRange,
    required String? searchValue,
  }) = _BingeFilter;

  static final defaultValue = BingeFilter(
    watchType: .all,
    fromRange: null,
    toRange: null,
    searchValue: null,
  );

  bool matches(VideoModel model) {
    if (watchType == .watched && !model.progressData.isFinished) {
      return false;
    } else if (watchType == .unwatched && model.progressData.isFinished) {
      return false;
    }

    if (fromRange != null) {
      if (fromRange!.isAfter(model.snippet.publishedAt)) {
        return false;
      }
    }
    if (toRange != null) {
      if (toRange!.isBefore(model.snippet.publishedAt)) {
        return false;
      }
    }

    if (searchValue != null && searchValue!.trim().isNotEmpty) {
      if (!model.snippet.title.toLowerCase().contains(
        searchValue!.toLowerCase(),
      )) {
        return false;
      }
    }
    return true;
  }
}
