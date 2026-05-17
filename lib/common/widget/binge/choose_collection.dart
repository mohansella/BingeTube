import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:flutter/material.dart';

class ChooseCollectionWidget extends StatefulWidget {
  final String title;

  const ChooseCollectionWidget({super.key, this.title = 'Choose collection'});

  @override
  State<ChooseCollectionWidget> createState() => _ChooseCollectionWidgetState();

  static Future<Collection?> showChooseCollection(
    BuildContext context, {
    String title = 'Choose collection',
  }) {
    final theme = Theme.of(context);
    return showModalBottomSheet<Collection>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ChooseCollectionWidget(title: title);
      },
    );
  }
}

class _ChooseCollectionWidgetState extends State<ChooseCollectionWidget> {
  late BingeDao _bingeDao;
  late final TextEditingController _searchController;
  List<CollectionModel> _collections = [];
  bool _isLoading = true;
  bool _isCreating = false;
  String _query = '';

  String get _trimmedQuery => _query.trim();

  List<CollectionModel> get _filteredCollections {
    final query = _normalize(_query);
    if (query.isEmpty) {
      return _collections;
    }
    return _collections
        .where((model) => _normalize(model.collection.name).contains(query))
        .toList();
  }

  bool get _canCreateCollection {
    final name = _normalize(_trimmedQuery);
    if (name.isEmpty) {
      return false;
    }
    return !_collections.any((model) => _normalize(model.collection.name) == name);
  }

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
    _searchController = TextEditingController();
    _bingeDao.streamCollectionModels(isSystem: false).first.then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        _collections = value;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final filteredCollections = _filteredCollections;

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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                child: _buildCreateAction(context),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              Expanded(
                child: _isLoading
                    ? _buildLoadingState()
                    : filteredCollections.isEmpty
                    ? _buildListEmpty(context)
                    : _buildList(scroll, filteredCollections),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final totalCount = _collections.length;

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
              Icons.collections_bookmark_outlined,
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
                  _isLoading
                      ? 'Loading collections...'
                      : _collectionCountLabel(totalCount),
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
          hintText: 'Search or create collection',
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

  Widget _buildCreateAction(BuildContext context) {
    if (!_canCreateCollection) {
      return const SizedBox.shrink();
    }

    return Padding(
      key: ValueKey(_trimmedQuery),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _isCreating ? null : _createCollection,
          icon: _isCreating
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add),
          label: Text(
            _isCreating ? 'Creating...' : 'Create "$_trimmedQuery"',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildList(ScrollController scroll, List<CollectionModel> filteredCollections) {
    return ListView.separated(
      controller: scroll,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      itemCount: filteredCollections.length,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final model = filteredCollections[index];
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: _buildTileIcon(context),
          title: Text(
            model.collection.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            _seriesCountLabel(model.series.length),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop(model.collection);
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
      child: Icon(Icons.folder_outlined, color: theme.colorScheme.onSecondaryContainer),
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
              hasQuery ? Icons.search_off : Icons.folder_open_outlined,
              size: 42,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              hasQuery ? 'No matching collections' : 'No collections yet',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              hasQuery
                  ? 'Try another name or create "$_trimmedQuery".'
                  : 'Search for a name to create your first collection.',
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

  Future<void> _createCollection() async {
    final name = _trimmedQuery;
    if (name.isEmpty) {
      return;
    }

    final normalizedName = _normalize(name);
    CollectionModel? existingCollection;
    for (final model in _collections) {
      if (_normalize(model.collection.name) == normalizedName) {
        existingCollection = model;
        break;
      }
    }
    if (existingCollection != null) {
      if (mounted) {
        Navigator.of(context).pop(existingCollection.collection);
      }
      return;
    }

    setState(() {
      _isCreating = true;
    });

    final collection = await _bingeDao.createCollection(
      name: name,
      description: '',
      isSystem: false,
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(collection);
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

  String _collectionCountLabel(int count) {
    return '$count ${count == 1 ? 'collection' : 'collections'} available';
  }

  String _seriesCountLabel(int count) {
    if (count == 0) {
      return 'No series';
    }
    return '$count series';
  }
}
