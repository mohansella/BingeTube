import 'package:bingetube/core/db/access/videos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/core/binge/binge_sort.freezed.dart';

enum BingeSortOrder {
  asc('Ascending'),
  desc('Descendeing');

  final String lable;

  const BingeSortOrder(this.lable);
}

enum BingeSortType {
  system('Default'),
  name('Name'),
  date('Date'),
  viewCount('ViewCount');

  final String lable;

  const BingeSortType(this.lable);
}

@freezed
abstract class BingeSort with _$BingeSort {
  const BingeSort._();

  const factory BingeSort({
    required BingeSortType sortType,
    required BingeSortOrder sortOrder,
  }) = _BingeSort;

  static final defaultValue = BingeSort(sortType: .system, sortOrder: .asc);

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
