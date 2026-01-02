import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:flutter/material.dart';

class BingeRefineWidget extends StatefulWidget {
  final BingeFilter filter;
  final BingeSort sort;
  final Function(BingeFilter) onFilterUpdate;
  final Function(BingeSort) onSortUpdate;
  final Future<bool> Function(Type) onShowModal;
  final DateTime minDateTime;
  final DateTime maxDateTime;
  final bool isCustomSort;

  const BingeRefineWidget({
    super.key,
    required this.filter,
    required this.sort,
    required this.onFilterUpdate,
    required this.onSortUpdate,
    required this.onShowModal,
    required this.minDateTime,
    required this.maxDateTime,
    this.isCustomSort = false,
  });

  @override
  State<BingeRefineWidget> createState() => _BingeRefineWidgetState();
}

class _BingeRefineWidgetState extends State<BingeRefineWidget> {
  final _textController = TextEditingController();

  bool _isShowSearchInput = false;

  @override
  void didUpdateWidget(covariant BingeRefineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: Align(
        alignment: .center,
        child: _isShowSearchInput
            ? _buildSearchInput()
            : SingleChildScrollView(
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
    var iconData = Icons.arrow_downward;
    if (!widget.isCustomSort && widget.sort.sortOrder == .asc) {
      iconData = Icons.arrow_upward;
    }
    return _buildChip(
      context,
      iconData,
      widget.isCustomSort ? 'Custom' : widget.sort.sortType.lable,
      (_) => _showModalForSort(context),
      !widget.isCustomSort &&
          widget.sort.sortOrder == .asc &&
          widget.sort.sortType == .system,
    );
  }

  Widget _buildVisibility(BuildContext context) {
    return _buildChip(
      context,
      Icons.visibility,
      widget.filter.watchType.lable,
      (_) => _showModalForVisibility(context),
      widget.filter.watchType == .all,
    );
  }

  Widget _buildDateRange(BuildContext context) {
    final isDefault =
        widget.filter.fromRange == null && widget.filter.toRange == null;
    return _buildChip(
      context,
      Icons.date_range,
      isDefault
          ? 'All Time'
          : '${widget.filter.fromRange?.toString().substring(0, 10) ?? ""}'
                '- ${widget.filter.toRange?.toString().substring(0, 10) ?? ""}',
      (_) => _showModalForDateRange(context),
      isDefault,
    );
  }

  Widget _buildSearch(BuildContext context) {
    final isDefault = widget.filter.searchValue == null;
    return _buildChip(
      context,
      Icons.search,
      isDefault ? 'Search' : '${widget.filter.searchValue}',
      (_) async {
        if (await widget.onShowModal(String)) {
          setState(() {
            _isShowSearchInput = true;
          });
        }
      },
      isDefault,
    );
  }

  Widget _buildSearchInput() {
    return SizedBox(
      height: 36,
      child: TextField(
        textAlign: .center,
        controller: _textController,
        autofocus: true,
        onTapOutside: (_) {
          _textController.text = widget.filter.searchValue ?? '';
          setState(() {
            _isShowSearchInput = false;
          });
        },
        onChanged: (value) {
          final searchValue = value.trim().isNotEmpty ? value.trim() : null;
          widget.onFilterUpdate(
            widget.filter.copyWith(searchValue: searchValue),
          );
        },
        onSubmitted: (value) {
          final searchValue = value.trim().isNotEmpty ? value.trim() : null;
          widget.onFilterUpdate(
            widget.filter.copyWith(searchValue: searchValue),
          );
          _textController.text = searchValue ?? '';
          setState(() {
            _isShowSearchInput = false;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 10.0),
        ),
      ),
    );
  }

  void _showModalForSort(BuildContext context) async {
    if (await widget.onShowModal(BingeSort) && context.mounted) {
      _showModal(context, _buildModalForSort);
    }
  }

  void _showModalForVisibility(BuildContext context) async {
    if (await widget.onShowModal(BingeFilterWatchType) && context.mounted) {
      _showModal(context, _buildModalForVisibility);
    }
  }

  void _showModalForDateRange(BuildContext context) async {
    if (await widget.onShowModal(DateTime) && context.mounted) {
      final range = await showDateRangePicker(
        context: context,
        firstDate: widget.minDateTime,
        lastDate: widget.maxDateTime,
        initialEntryMode: .calendar,
      );
      final fromTime = range?.start;
      var endTime = range?.end;
      if (endTime != null) {
        final date = endTime;
        endTime = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
      }
      widget.onFilterUpdate(
        widget.filter.copyWith(fromRange: fromTime, toRange: endTime),
      );
    }
  }

  void _showModal(
    BuildContext context,
    List<Widget> Function(
      BingeFilter,
      BingeSort,
      Function(BingeFilter),
      Function(BingeSort),
    )
    children,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        var filter = widget.filter;
        var sort = widget.sort;
        return StatefulBuilder(
          builder: (_, setModalState) {
            setFilter(BingeFilter value) {
              widget.onFilterUpdate(value);
              setModalState(() {
                filter = value;
              });
            }

            setOrder(BingeSort value) {
              widget.onSortUpdate(value);
              setModalState(() {
                sort = value;
              });
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children(filter, sort, setFilter, setOrder),
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
    BingeFilter _,
    BingeSort sort,
    Function(BingeFilter) _,
    Function(BingeSort) setSort,
  ) {
    return [
      const Text('Sort by', style: TextStyle(fontWeight: FontWeight.w600)),

      RadioGroup<BingeSortType>(
        groupValue: sort.sortType,
        onChanged: (sortType) => setSort(sort.copyWith(sortType: sortType!)),
        child: Column(
          children: BingeSortType.values.map((sortType) {
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
      RadioGroup<BingeSortOrder>(
        groupValue: sort.sortOrder,
        onChanged: (sortOrder) => setSort(sort.copyWith(sortOrder: sortOrder!)),
        child: Column(
          children: BingeSortOrder.values.map((sortOrder) {
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
    BingeSort _,
    Function(BingeFilter) setFilter,
    Function(BingeSort) _,
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
