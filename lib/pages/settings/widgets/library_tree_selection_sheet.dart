import 'package:flutter/material.dart';

class LibraryTreeCollection {
  final String id;
  final String title;
  final String? subtitle;
  final List<LibraryTreeSeries> series;

  const LibraryTreeCollection({
    required this.id,
    required this.title,
    this.subtitle,
    required this.series,
  });
}

class LibraryTreeSeries {
  final String id;
  final String title;

  const LibraryTreeSeries({required this.id, required this.title});
}

class LibraryTreeSelection {
  final Map<String, Set<String>> collectionIdVsSeriesIds;

  LibraryTreeSelection(Map<String, Set<String>> collectionIdVsSeriesIds)
    : collectionIdVsSeriesIds = {
        for (final entry in collectionIdVsSeriesIds.entries)
          entry.key: Set.unmodifiable(entry.value),
      };

  bool get isEmpty => collectionIdVsSeriesIds.isEmpty;

  Set<String> seriesForCollection(String collectionId) {
    return collectionIdVsSeriesIds[collectionId] ?? {};
  }
}

class LibraryTreeSelectionSheet extends StatefulWidget {
  final String title;
  final String actionLabel;
  final List<LibraryTreeCollection> collections;

  const LibraryTreeSelectionSheet({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.collections,
  });

  static Future<LibraryTreeSelection?> show(
    BuildContext context, {
    required String title,
    required String actionLabel,
    required List<LibraryTreeCollection> collections,
  }) {
    return showModalBottomSheet<LibraryTreeSelection>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) => LibraryTreeSelectionSheet(
        title: title,
        actionLabel: actionLabel,
        collections: collections,
      ),
    );
  }

  @override
  State<LibraryTreeSelectionSheet> createState() => _LibraryTreeSelectionSheetState();
}

class _LibraryTreeSelectionSheetState extends State<LibraryTreeSelectionSheet> {
  static const _expandedSeriesThreshold = 40;

  late final Map<String, Set<String>> _selected;
  late final int _totalSeriesCount;

  @override
  void initState() {
    super.initState();
    _totalSeriesCount = widget.collections.fold(
      0,
      (total, collection) => total + collection.series.length,
    );
    _selected = {
      for (final collection in widget.collections)
        collection.id: collection.series.map((series) => series.id).toSet(),
    };
  }

  bool get _isAllSelected {
    if (widget.collections.isEmpty) {
      return false;
    }
    return widget.collections.every((collection) {
      if (!_selected.containsKey(collection.id)) {
        return false;
      }
      return _selected[collection.id]!.length == collection.series.length;
    });
  }

  int get _selectedSeriesCount {
    return _selected.values.fold(0, (total, series) => total + series.length);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCollectionCount = _selected.length;
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: widget.collections.isEmpty ? null : _toggleAll,
                    icon: Icon(
                      _isAllSelected
                          ? Icons.deselect_outlined
                          : Icons.select_all_outlined,
                    ),
                    label: Text(_isAllSelected ? 'Clear all' : 'Select all'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$selectedCollectionCount/${widget.collections.length} collections, '
                '$_selectedSeriesCount/$_totalSeriesCount series selected',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(
              child: widget.collections.isEmpty
                  ? const Center(child: Text('No library items found'))
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: widget.collections.length,
                      itemBuilder: (context, index) {
                        return _buildCollection(widget.collections[index]);
                      },
                    ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _selected.isEmpty
                        ? null
                        : () =>
                              Navigator.of(context).pop(LibraryTreeSelection(_selected)),
                    child: Text(widget.actionLabel),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCollection(LibraryTreeCollection collection) {
    if (collection.series.isEmpty) {
      return CheckboxListTile(
        value: _selected.containsKey(collection.id),
        onChanged: (_) => _toggleCollection(collection),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(collection.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(collection.subtitle ?? 'No series'),
      );
    }

    return ExpansionTile(
      initiallyExpanded: _totalSeriesCount <= _expandedSeriesThreshold,
      leading: Checkbox(
        tristate: true,
        value: _collectionCheckboxValue(collection),
        onChanged: (_) => _toggleCollection(collection),
      ),
      title: Text(collection.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        collection.subtitle ?? '${collection.series.length} series',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        for (final series in collection.series)
          CheckboxListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 56, right: 24),
            value: _selected[collection.id]?.contains(series.id) ?? false,
            onChanged: (_) => _toggleSeries(collection, series),
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(series.title, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
      ],
    );
  }

  bool? _collectionCheckboxValue(LibraryTreeCollection collection) {
    final selectedSeries = _selected[collection.id];
    if (selectedSeries == null || selectedSeries.isEmpty) {
      return false;
    }
    if (selectedSeries.length == collection.series.length) {
      return true;
    }
    return null;
  }

  void _toggleAll() {
    setState(() {
      if (_isAllSelected) {
        _selected.clear();
      } else {
        _selected
          ..clear()
          ..addEntries(
            widget.collections.map(
              (collection) => MapEntry(
                collection.id,
                collection.series.map((series) => series.id).toSet(),
              ),
            ),
          );
      }
    });
  }

  void _toggleCollection(LibraryTreeCollection collection) {
    setState(() {
      if (collection.series.isEmpty) {
        if (_selected.containsKey(collection.id)) {
          _selected.remove(collection.id);
        } else {
          _selected[collection.id] = {};
        }
        return;
      }

      final value = _collectionCheckboxValue(collection);
      if (value == true) {
        _selected.remove(collection.id);
      } else {
        _selected[collection.id] = collection.series.map((series) => series.id).toSet();
      }
    });
  }

  void _toggleSeries(LibraryTreeCollection collection, LibraryTreeSeries series) {
    setState(() {
      final selectedSeries = {...?_selected[collection.id]};
      if (selectedSeries.contains(series.id)) {
        selectedSeries.remove(series.id);
      } else {
        selectedSeries.add(series.id);
      }

      if (selectedSeries.isEmpty) {
        _selected.remove(collection.id);
      } else {
        _selected[collection.id] = selectedSeries;
      }
    });
  }
}
