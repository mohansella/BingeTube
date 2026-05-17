import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:flutter/material.dart';

class ChooseSeryWidget extends StatefulWidget {
  final String title;

  const ChooseSeryWidget({super.key, this.title = 'Choose series'});

  @override
  State<ChooseSeryWidget> createState() => _ChooseSeryWidgetState();

  static Future<Sery?> showChooseCollection(
    BuildContext context, {
    String title = 'Choose series',
  }) {
    return showChooseSeries(context, title: title);
  }

  static Future<Sery?> showChooseSeries(
    BuildContext context, {
    String title = 'Choose series',
  }) {
    final theme = Theme.of(context);
    return showModalBottomSheet<Sery>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ChooseSeryWidget(title: title);
      },
    );
  }
}

class _ChooseSeryWidgetState extends State<ChooseSeryWidget> {
  late BingeDao _bingeDao;
  late final TextEditingController _searchController;
  List<_SeriesChoice> _series = [];
  bool _isLoading = true;
  String _query = '';

  String get _trimmedQuery => _query.trim();

  List<_SeriesChoice> get _filteredSeries {
    final query = _normalize(_query);
    if (query.isEmpty) {
      return _series;
    }
    return _series.where((choice) {
      return _normalize(choice.sery.name).contains(query) ||
          _normalize(choice.collectionName).contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
    _searchController = TextEditingController();
    _loadSeries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSeries() async {
    final collections = await _bingeDao.streamCollectionModels(isSystem: false).first;
    final series = <_SeriesChoice>[
      for (final collection in collections)
        for (final sery in collection.series)
          _SeriesChoice(
            sery: sery.sery,
            collectionName: collection.collection.name,
            totalVideos: sery.totalVideos,
            watchedVideos: sery.watchedVideos,
          ),
    ];

    series.sort((a, b) {
      final updatedCompare = b.sery.updatedAt.compareTo(a.sery.updatedAt);
      if (updatedCompare != 0) {
        return updatedCompare;
      }
      return a.sery.name.toLowerCase().compareTo(b.sery.name.toLowerCase());
    });

    if (!mounted) {
      return;
    }

    setState(() {
      _series = series;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final filteredSeries = _filteredSeries;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: 0.68,
        minChildSize: 0.42,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scroll) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              _buildSearchField(context),
              const SizedBox(height: 8),
              const Divider(height: 1),
              Expanded(
                child: _isLoading
                    ? _buildLoadingState()
                    : filteredSeries.isEmpty
                    ? _buildListEmpty(context)
                    : _buildList(scroll, filteredSeries),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final totalCount = _series.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.video_library_outlined,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isLoading ? 'Loading series...' : _seriesCountLabel(totalCount),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search series or collection',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Clear search',
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.close),
                ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        onChanged: (value) => setState(() {
          _query = value;
        }),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildList(ScrollController scroll, List<_SeriesChoice> filteredSeries) {
    return ListView.separated(
      controller: scroll,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      itemCount: filteredSeries.length,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final choice = filteredSeries[index];
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: _buildTileIcon(context),
          title: Text(choice.sery.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            '${choice.collectionName} - ${_videoProgressLabel(choice)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop(choice.sery);
          },
        );
      },
    );
  }

  Widget _buildTileIcon(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.playlist_play_outlined,
        color: theme.colorScheme.onSecondaryContainer,
      ),
    );
  }

  Widget _buildListEmpty(BuildContext context) {
    final theme = Theme.of(context);
    final hasQuery = _trimmedQuery.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasQuery ? Icons.search_off : Icons.video_library_outlined,
              size: 42,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              hasQuery ? 'No matching series' : 'No series yet',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              hasQuery
                  ? 'Try another series or collection name.'
                  : 'Create or save a series before copying videos.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _query = '';
    });
  }

  String _normalize(String value) {
    return value.trim().toLowerCase();
  }

  String _seriesCountLabel(int count) {
    return '$count ${count == 1 ? 'series' : 'series'} available';
  }

  String _videoProgressLabel(_SeriesChoice choice) {
    if (choice.totalVideos == 0) {
      return 'No videos';
    }
    if (choice.watchedVideos == 0) {
      return '${choice.totalVideos} ${choice.totalVideos == 1 ? 'video' : 'videos'}';
    }
    return '${choice.watchedVideos}/${choice.totalVideos} watched';
  }
}

class _SeriesChoice {
  final Sery sery;
  final String collectionName;
  final int totalVideos;
  final int watchedVideos;

  const _SeriesChoice({
    required this.sery,
    required this.collectionName,
    required this.totalVideos,
    required this.watchedVideos,
  });
}
