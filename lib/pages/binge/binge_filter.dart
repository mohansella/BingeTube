import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/pages/binge/binge_filter.freezed.dart';

enum BingeFilterWatchType { all, watched, unwatched }

enum BingeFilterSortOrder { asc, desc }

enum BingeFilterSortType { system, name, date, viewCount }

@freezed
abstract class BingeFilter with _$BingeFilter {
  const factory BingeFilter({
    required BingeFilterWatchType watchType,
    required BingeFilterSortOrder sortOder,
    required BingeFilterSortType sortType,
    required String? searchValue,
  }) = _BingeFilter;
}

class BingeFilterWidget extends StatelessWidget {
  final BingeFilter filter;
  final Function(BingeFilter) onUpdate;

  const BingeFilterWidget({
    super.key,
    required this.filter,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: Align(
        alignment: .centerLeft,
        child: SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 8.0,
            children: [
              _buildSort(context),
              _buildVisibility(context),
              _buildDateRange(context),
              _buildSearch(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    IconData icon,
    String text,
    Function(bool) onSelected,
  ) {
    return FilterChip(
      padding: EdgeInsets.only(right: 2.0),
      label: Row(
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Icon(icon, size: 16),
          ),
          Text(text, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
      onSelected: onSelected,
    );
  }

  Widget _buildSort(BuildContext context) {
    return _buildChip(context, Icons.arrow_downward, 'Default', (_) {});
  }

  Widget _buildVisibility(BuildContext context) {
    return _buildChip(context, Icons.visibility, 'All', (_) {});
  }

  _buildDateRange(BuildContext context) {
    return _buildChip(context, Icons.date_range, 'All Time', (_) {});
  }

  _buildSearch(BuildContext context) {
    return _buildChip(context, Icons.search, 'Search', (_) {});
  }
}
