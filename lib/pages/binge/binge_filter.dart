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
}
