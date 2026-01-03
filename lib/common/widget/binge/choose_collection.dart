import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseCollectionWidget extends StatefulWidget {
  final void Function(Collection value) onChoose;
  const ChooseCollectionWidget({super.key, required this.onChoose});

  @override
  State<ChooseCollectionWidget> createState() => _ChooseCollectionWidgetState();

  static Future<Collection?> showChooseCollection(BuildContext context) async {
    Collection? toReturn;
    void onChoose(Collection value) {
      toReturn = value;
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return ChooseCollectionWidget(onChoose: onChoose);
      },
    );
    return toReturn;
  }
}

class _ChooseCollectionWidgetState extends State<ChooseCollectionWidget> {
  late BingeDao _bingeDao;
  late List<Collection> _collections;
  bool _isLoading = true;
  String? _inputValue;

  List<Collection> get _filteredCollection {
    if (_inputValue == null) {
      return _collections;
    }
    return _collections.where((c) => c.name.contains(_inputValue!)).toList();
  }

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
    _bingeDao.getCollections(isSystem: false).then((value) {
      setState(() {
        _collections = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator();
    }
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scroll) {
        final theme = Theme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Choose collection',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Search or create collection',
                        hintStyle: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant.withAlpha(150),
                            ),
                      ),
                      onChanged: (v) => setState(() {
                        _inputValue = v;
                      }),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed:
                        (_inputValue == null || _inputValue!.trim().isEmpty)
                        ? null
                        : () async {
                            final collection = await _bingeDao.createCollection(
                              _inputValue!,
                              '',
                              false,
                            );
                            widget.onChoose(collection);
                            if (context.mounted) {
                              context.pop();
                            }
                          },

                    child: const Text('Create'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),

            // Collection list (scrolls)
            Expanded(
              child: _filteredCollection.isEmpty
                  ? _buildListEmpty()
                  : _buildList(scroll),
            ),
          ],
        );
      },
    );
  }

  ListView _buildList(ScrollController scroll) {
    return ListView.builder(
      controller: scroll,
      itemCount: _filteredCollection.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredCollection[index].name),
          onTap: () {
            widget.onChoose(_filteredCollection[index]);
            context.pop();
          },
        );
      },
    );
  }

  Widget _buildListEmpty() {
    return Center(
      child: const Text('No collections found for the given search value'),
    );
  }
}
