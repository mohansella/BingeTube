import 'package:bingetube/app/routes.dart';
import 'package:bingetube/common/widget/binge/choose_collection.dart';
import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/common/widget/refine/refine_widget.dart';
import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditBingePage extends ConsumerStatefulWidget {
  final Map<String, String> params;

  const EditBingePage(this.params, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditBingePageState();

  static Map<String, String> buildParams(Map<String, String> params) {
    return Map.fromEntries(
      [
        BingeParams.type,
        BingeParams.id,
      ].map((v) => MapEntry(v.name, params[v.name]!)),
    );
  }
}

class _EditBingePageState extends ConsumerState<EditBingePage> {
  final Set<String> _checkMarked = {};
  final List<String> _sortOrder = [];

  bool _isLoading = true;
  bool _showTitle = false;
  bool _isOrderModified = false;
  late BingeModel _unfilteredModel;
  late BingeDao _bingeDao;
  late Collection _collection;

  late BingeController _controller;
  TextEditingController? _editTitleController;
  TextEditingController? _editDescriptionController;

  get _isDrag => _controller.filter == BingeFilter.defaultValue;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
    _bingeDao = BingeDao(Database());
    initAsync();
  }

  void initAsync() async {
    final (model, collection) = await (
      _controller.stream.first,
      _bingeDao.getDefaultCollection(),
    ).wait;
    setState(() {
      _isLoading = false;
      _unfilteredModel = model;
      _collection = collection;
      _resetOrder();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _editTitleController?.dispose();
    _editDescriptionController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snashot) {
        if (_isLoading || !snashot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final model = snashot.data!;
        var filteredVideos = model.videos;
        if (_isDrag) {
          final idVsVideos = Map.fromEntries(
            filteredVideos.map((v) => MapEntry(v.video.id, v)),
          );
          filteredVideos = _sortOrder.map((id) => idVsVideos[id]!).toList();
        }
        return Scaffold(
          appBar: _buildAppBar(context, filteredVideos),
          body: _buildList(filteredVideos),
        );
      },
    );
  }

  Widget _buildList(List<VideoModel> videos) {
    return ReorderableListView.builder(
      itemBuilder: (context, i) => _buildVideoCard(videos[i], i),
      itemCount: videos.length,
      onReorder: _onReorder,
      buildDefaultDragHandles: false,
    );
  }

  AppBar _buildAppBar(BuildContext context, List<VideoModel> filteredVideos) {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 16.0),
      leading: IconButton(
        onPressed: () => Routes.popOrHome(context),
        icon: Icon(Icons.arrow_back),
        tooltip: 'Back',
      ),
      title: _buildTitle(context, filteredVideos),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _showTitle = !_showTitle;
            });
          },
          icon: Icon(_showTitle ? Icons.expand_less : Icons.expand_more),
        ),
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.check),
          tooltip: 'Save',
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_showTitle ? 162 : 50),
        child: Center(
          child: Column(
            children: [
              if (_showTitle) ...[_buildEditTitle()],
              _buildAppBarBottom(filteredVideos),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditTitle() {
    final model = _unfilteredModel;
    _editTitleController ??= TextEditingController(text: model.title);
    _editDescriptionController ??= TextEditingController(
      text: model.description,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tooltip(
            message: 'Choose Collection',
            child: InkWell(
              onTap: _chooseCollection,
              child: Row(
                mainAxisSize: .min,
                children: [
                  Icon(Icons.folder),
                  SizedBox(width: 8),
                  Text(
                    _collection.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          Tooltip(
            message: 'Edit Binge Title',
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.title),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    autofocus: true,
                    controller: _editTitleController,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Binge title',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          Tooltip(
            message: 'Edit Binge Description',
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.subject),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: _editDescriptionController,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Description',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, List<VideoModel> filteredVideos) {
    final model = _unfilteredModel;
    String subtitle;
    String prefix;
    if (_controller.filter == BingeFilter.defaultValue) {
      subtitle = '${model.videos.length} videos';
    } else {
      subtitle =
          'showing ${filteredVideos.length} of ${model.videos.length} videos';
    }
    if (_checkMarked.isEmpty) {
      prefix = '';
    } else {
      prefix = '${_checkMarked.length} checked · ';
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Column(
          children: [
            Text(
              'Edit Binge',
              maxLines: 1,
              overflow: .ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '$prefix$subtitle',
              maxLines: 1,
              overflow: .ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarBottom(List<VideoModel> filteredVideos) {
    final isAllSelected = filteredVideos.every(
      (v) => _checkMarked.contains(v.video.id),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 8.0),
            child: IconButton(
              onPressed: () => setState(() {
                final videoIds = filteredVideos.map((v) => v.video.id);
                if (isAllSelected) {
                  _checkMarked.removeAll(videoIds);
                } else {
                  _checkMarked.addAll(videoIds);
                }
              }),
              icon: Icon(
                isAllSelected ? Icons.check_box_outline_blank : Icons.done_all,
              ),
              tooltip: isAllSelected ? 'Deselect All' : 'Select All',
            ),
          ),
          Expanded(
            child: BingeRefineWidget(
              filter: _controller.filter,
              sort: _controller.sort,
              isCustomSort: _isOrderModified,
              minDateTime: _controller.minDateTime,
              maxDateTime: _controller.maxDateTime,
              onFilterUpdate: _onFilterModified,
              onSortUpdate: _onSortModified,
              onShowModal: _onShowModal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(VideoModel video, int index) {
    final isChecked = _checkMarked.contains(video.video.id);
    final theme = Theme.of(context);
    return Card(
      key: Key(video.video.id),
      color: isChecked ? theme.colorScheme.primaryContainer : null,
      shape: RoundedRectangleBorder(),
      child: InkWell(
        onTap: () => setState(() {
          if (isChecked) {
            _checkMarked.remove(video.video.id);
          } else {
            _checkMarked.add(video.video.id);
          }
        }),
        child: Row(
          children: [
            ReorderableDragStartListener(
              index: index,
              enabled: _isDrag,
              child: MouseRegion(
                cursor: _isDrag ? SystemMouseCursors.grab : MouseCursor.defer,
                child: SizedBox(
                  width: 160,
                  height: 90,
                  child: Stack(
                    alignment: .bottomCenter,
                    children: [
                      Image.network(video.thumbnails.mediumUrl, fit: .cover),
                      Container(color: Colors.black.withAlpha(50)),
                      if (video.progress.isFinished) ...[
                        LinearProgressIndicator(value: 1),
                      ],
                      if (_isDrag) ...[
                        Center(
                          child: Icon(
                            Icons.drag_handle_outlined,
                            size: 100,
                            color: Colors.white.withAlpha(120),
                          ),
                        ),
                      ],
                      Positioned(
                        left: 4.0,
                        top: 4.0,
                        child: Icon(
                          isChecked
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    video.snippet.title,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w500),
                  ),
                  Text(
                    video.snippet.channelTitle,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w200),
                  ),
                  Text(
                    video.snippet.description,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w300),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  void _onFilterModified(BingeFilter filter) {
    setState(() {
      _controller.setFilter(filter);
    });
  }

  void _onSortModified(BingeSort sort) {
    setState(() {
      _controller.setSort(sort);
      _resetOrder();
    });
  }

  Future<bool> _onShowModal(Type type) async {
    if (type != BingeSort) {
      return true;
    }
    if (!_isOrderModified) {
      return true;
    }
    final toReturn = CustomDialog.show(
      context,
      'Change sort order?',
      'Okay',
      const Text(
        'Switching to different will reset your custom ordering. Do you want to continue?',
      ),
      cancelText: 'Cancel',
    );
    return toReturn;
  }

  void _resetOrder() {
    _isOrderModified = false;
    final sortedVideos = [..._unfilteredModel.videos]
      ..sort(_controller.sort.compareModels);
    final sortedVideoIds = sortedVideos.map((v) => v.video.id).toList();
    _sortOrder
      ..clear()
      ..addAll(sortedVideoIds);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      _isOrderModified = true;
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      final item = _sortOrder.removeAt(oldIndex);
      _sortOrder.insert(newIndex, item);
    });
  }

  void _chooseCollection() async {
    final chosenCollection = await ChooseCollectionWidget.showChooseCollection(
      context,
    );
    if (chosenCollection == null) {
      return;
    }
    setState(() {
      _collection = chosenCollection;
    });
  }
}
