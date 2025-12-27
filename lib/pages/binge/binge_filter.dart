import 'package:bingetube/core/db/access/videos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/pages/binge/binge_filter.freezed.dart';

enum BingeFilterWatchType {
  all('All'),
  watched('Watched'),
  unwatched('Unwatched');

  final String lable;

  const BingeFilterWatchType(this.lable);
}

enum BingeFilterSortOrder {
  asc('Ascending'),
  desc('Descendeing');

  final String lable;

  const BingeFilterSortOrder(this.lable);
}

enum BingeFilterSortType {
  system('Default'),
  name('Name'),
  date('Date'),
  viewCount('ViewCount');

  final String lable;

  const BingeFilterSortType(this.lable);
}

@freezed
abstract class BingeFilter with _$BingeFilter {
  const BingeFilter._();

  const factory BingeFilter({
    required BingeFilterWatchType watchType,
    required BingeFilterSortOrder sortOrder,
    required BingeFilterSortType sortType,
    required DateTime? fromRange,
    required DateTime? toRange,
    required String? searchValue,
  }) = _BingeFilter;

  static final defaultValue = BingeFilter(
    watchType: .all,
    sortOrder: .asc,
    sortType: .system,
    fromRange: null,
    toRange: null,
    searchValue: null,
  );

  bool matches(VideoModel model) {
    if (watchType == .watched && !model.progress.isFinished) {
      return false;
    } else if (watchType == .unwatched && model.progress.isFinished) {
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

  int compareModels(VideoModel left, VideoModel right) {
    int result;
    switch (sortType) {
      case .name:
        result = left.snippet.title.compareTo(right.snippet.title);
        break;
      case .date:
        result = left.snippet.publishedAt.compareTo(right.snippet.publishedAt);
        break;
      case .viewCount:
        result = left.statistics.viewCount - left.statistics.viewCount;
        break;
      default:
        result = 0;
    }
    return sortOrder == .asc ? result : -result;
  }
}
