import 'package:bingetube/pages/binge/binge_filter.dart';
import 'package:flutter/material.dart';

class BingeFilterWidget extends StatelessWidget {
  final BingeFilter filter;
  final Function(BingeFilter) onUpdate;
  final Function(Type) onOpen;
  final DateTime minDateTime;
  final DateTime maxDateTime;

  const BingeFilterWidget({
    super.key,
    required this.filter,
    required this.onUpdate,
    required this.onOpen,
    required this.minDateTime,
    required this.maxDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: Align(
        alignment: .center,
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
    bool isDefault,
  ) {
    final theme = Theme.of(context);
    final isModified = !isDefault;

    return FilterChip(
      padding: const EdgeInsets.only(right: 2.0),
      selected: isModified,
      selectedColor: theme.colorScheme.primaryContainer,
      backgroundColor: theme.colorScheme.surfaceContainer,
      showCheckmark: false,
      label: Row(
        spacing: 4,
        children: [
          Icon(
            icon,
            size: 16,
            color: isModified
                ? theme.colorScheme.primary
                : theme.iconTheme.color,
          ),
          Text(
            text,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: isModified ? FontWeight.w600 : FontWeight.normal,
              color: isModified
                  ? theme.colorScheme.primary
                  : theme.textTheme.labelMedium?.color,
            ),
          ),
        ],
      ),
      onSelected: onSelected,
    );
  }

  Widget _buildSort(BuildContext context) {
    return _buildChip(
      context,
      filter.sortOrder == .asc ? Icons.arrow_downward : Icons.arrow_upward,
      filter.sortType.lable,
      (_) => _showModalForSort(context),
      filter.sortOrder == .asc && filter.sortType == .system,
    );
  }

  Widget _buildVisibility(BuildContext context) {
    return _buildChip(
      context,
      Icons.visibility,
      filter.watchType.lable,
      (_) => _showModalForVisibility(context),
      filter.watchType == .all,
    );
  }

  Widget _buildDateRange(BuildContext context) {
    final isDefault = filter.fromRange == null && filter.toRange == null;
    return _buildChip(
      context,
      Icons.date_range,
      isDefault
          ? 'All Time'
          : '${filter.fromRange?.toString().substring(0, 10) ?? ""}'
                '- ${filter.toRange?.toString().substring(0, 10) ?? ""}',
      (_) => _showModalForDateRange(context),
      isDefault,
    );
  }

  Widget _buildSearch(BuildContext context) {
    final isDefault = filter.searchValue == null;
    return _buildChip(
      context,
      Icons.search,
      isDefault ? 'Search' : '${filter.searchValue}',
      (_) => _showSearchInput(),
      isDefault,
    );
  }

  void _showModalForSort(BuildContext context) {
    onOpen(BingeFilterSortType);
    _showModal(context, _buildModalForSort);
  }

  void _showModalForVisibility(BuildContext context) {
    onOpen(BingeFilterWatchType);
    _showModal(context, _buildModalForVisibility);
  }

  void _showModalForDateRange(BuildContext context) async {
    onOpen(DateTime);
    final range = await showDateRangePicker(
      context: context,
      firstDate: minDateTime,
      lastDate: maxDateTime,
      initialEntryMode: .calendar,
    );
    final fromDateTime = range?.start;
    var endDateTime = range?.end;
    if (endDateTime != null) {
      final date = endDateTime;
      endDateTime = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    }
    onUpdate(filter.copyWith(fromRange: fromDateTime, toRange: endDateTime));
  }

  void _showSearchInput() {
    onOpen(String);
  }

  void _showModal(
    BuildContext context,
    List<Widget> Function(BingeFilter, void Function(BingeFilter))
    widgetsBuilder,
  ) {
    var localFilter = filter;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            setFilter(BingeFilter newFilter) {
              setModalState(() {
                localFilter = newFilter;
                onUpdate(newFilter);
              });
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widgetsBuilder(localFilter, setFilter),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildModalForSort(
    BingeFilter filter,
    void Function(BingeFilter) setFilter,
  ) {
    return [
      const Text('Sort by', style: TextStyle(fontWeight: FontWeight.w600)),

      RadioGroup<BingeFilterSortType>(
        groupValue: filter.sortType,
        onChanged: (sortType) =>
            setFilter(filter.copyWith(sortType: sortType!)),
        child: Column(
          children: BingeFilterSortType.values.map((sortType) {
            return RadioListTile(
              value: sortType,
              title: Center(child: Text(sortType.lable)),
            );
          }).toList(),
        ),
      ),

      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),

      const Text('Order', style: TextStyle(fontWeight: FontWeight.w600)),
      RadioGroup<BingeFilterSortOrder>(
        groupValue: filter.sortOrder,
        onChanged: (sortOrder) =>
            setFilter(filter.copyWith(sortOrder: sortOrder!)),
        child: Column(
          children: BingeFilterSortOrder.values.map((sortOrder) {
            return RadioListTile(
              value: sortOrder,
              title: Center(child: Text(sortOrder.lable)),
            );
          }).toList(),
        ),
      ),
    ];
  }

  List<Widget> _buildModalForVisibility(
    BingeFilter filter,
    void Function(BingeFilter) setFilter,
  ) {
    return [
      const Text('Visibility', style: TextStyle(fontWeight: FontWeight.w600)),

      RadioGroup<BingeFilterWatchType>(
        groupValue: filter.watchType,
        onChanged: (watchType) =>
            setFilter(filter.copyWith(watchType: watchType!)),
        child: Column(
          children: BingeFilterWatchType.values.map((watchType) {
            return RadioListTile(
              value: watchType,
              title: Center(child: Text(watchType.lable)),
            );
          }).toList(),
        ),
      ),
    ];
  }
}
