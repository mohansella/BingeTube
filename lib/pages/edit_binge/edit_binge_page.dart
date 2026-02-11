import 'package:bingetube/app/routes.dart';
import 'package:bingetube/app/theme.dart';
import 'package:bingetube/common/widget/binge/choose_collection.dart';
import 'package:bingetube/common/widget/binge/choose_sery.dart';
import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/common/widget/refine/refine_widget.dart';
import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditBingePage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('EditBingePage');

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
        if (_checkMarked.isNotEmpty)
          IconButton(
            icon: Icon(Icons.copy_outlined),
            tooltip: 'Copy',
            onPressed: _onCopyPressed,
          ),

        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.check),
          tooltip: 'Save',
          onPressed: _onSavePressed,
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
                      Image.network(
                        video.thumbnails.mediumUrl,
                        fit: .cover,
                        frameBuilder: (c, child, frame, wasSyncLoaded) {
                          if (frame != null || wasSyncLoaded) {
                            return child;
                          }
                          return _buildCoverFallback(c, video.video.id);
                        },
                        errorBuilder: (c, _, _) =>
                            _buildCoverFallback(c, video.video.id),
                      ),
                      Container(color: Colors.black.withAlpha(50)),
                      LinearProgressIndicator(value: video.progressPercent),
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

  Widget _buildCoverFallback(BuildContext context, String id) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(id, brightness);
    return Container(color: color, alignment: .center);
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
    final sort = _controller.sort;
    List<VideoModel> sortedVideos;
    if (sort.sortType == .system && sort.sortOrder == .desc) {
      sortedVideos = [..._unfilteredModel.videos].reversed.toList();
    } else {
      sortedVideos = [..._unfilteredModel.videos]..sort(sort.compareModels);
    }

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

  void _onCopyPressed() async {
    final chosenSery = await ChooseSeryWidget.showChooseCollection(context);
    if (chosenSery == null) {
      return;
    }

    final targetModel = await _bingeDao.streamBingeModel(chosenSery.id).first;
    final sourceSet = {..._checkMarked};
    sourceSet.removeAll(targetModel.videos.map((v) => v.video.id));
    final localContext = context;
    if (!localContext.mounted) {
      return;
    }
    if (sourceSet.isEmpty) {
      CustomDialog.show(
        localContext,
        'Nothing to Copy!',
        'Okay',
        Text(
          'All Selected videos already present in target series: ${targetModel.title}',
        ),
      );
      return;
    }

    final copyConsent = await CustomDialog.show(
      localContext,
      'Copy ${sourceSet.length} videos?',
      'Copy',
      Text(
        'This action will copy ${sourceSet.length} videos from the selected ${_checkMarked.length} videos to series: ${targetModel.title}',
      ),
      cancelText: 'Cancel',
    );
    if (!copyConsent) {
      return;
    }

    final sourceList = _sortOrder.where((v) => sourceSet.contains(v)).toList();
    await _bingeDao.addVideos(
      chosenSery.id,
      sourceList,
      targetModel.videos.length,
    );
    if (localContext.mounted) {
      Routes.popOrHome(localContext);
    }
  }

  void _onSavePressed() async {
    if (_checkMarked.isEmpty) {
      CustomDialog.show(
        context,
        'No videos selected',
        'Okay',
        const Text(
          'You haven’t selected any videos to save. Select at least one video to continue.',
        ),
      );
      return;
    }

    final title = _editTitleController?.text ?? _unfilteredModel.title;
    final description =
        _editDescriptionController?.text ?? _unfilteredModel.description;
    final idVsVideoEntries = _unfilteredModel.videos.map(
      (v) => MapEntry(v.video.id, v),
    );
    final idVsVideos = Map.fromEntries(idVsVideoEntries);
    final videos = _sortOrder.map((id) => idVsVideos[id]!).toList();
    videos.removeWhere((v) => !_checkMarked.contains(v.video.id));
    final newModel = BingeModel(
      title: title,
      description: description,
      videos: videos,
    );

    final actions = _controller.supportedActions();
    if (actions.length == 1 && actions[0] == .add) {
      _saveNewModel(newModel);
    } else {
      _updateExistingeModel(newModel);
    }
  }

  void _updateExistingeModel(BingeModel model) async {
    final canUpdate = await CustomDialog.show(
      context,
      'Update selected videos?',
      'Update',
      Text(
        'You’ve selected ${model.videos.length} of ${_unfilteredModel.videos.length} videos. '
        'Their order will be updated for this collection.',
      ),
      cancelText: 'Cancel',
    );

    if (!canUpdate) {
      return;
    }

    final coverVideo = model.videos.firstWhere(
      (v) => v.progressData.isFinished,
      orElse: () => model.videos[0],
    );

    _isLoading = true;
    final seryModel = await _controller.executeBingeAction(
      .edit,
      collection: _collection,
      model: model,
      coverVideo: coverVideo,
    );

    EditBingePage._logger.info('series updated $seryModel');
    final localContext = context;
    if (localContext.mounted) {
      while (localContext.canPop()) {
        localContext.pop();
      }
      localContext.goNamed(Pages.myShows.name);
    }
  }

  void _saveNewModel(BingeModel newModel) async {
    final canSave = await CustomDialog.show(
      context,
      'Save selected videos?',
      'Save',
      Text(
        'You’ve selected ${newModel.videos.length} of ${_unfilteredModel.videos.length} videos. '
        'Their order will be saved for this collection.',
      ),
      cancelText: 'Cancel',
    );

    if (!canSave) {
      return;
    }

    final coverVideo = newModel.videos.firstWhere(
      (v) => v.progressData.isFinished,
      orElse: () => newModel.videos[0],
    );

    final seryModel = await _controller.executeBingeAction(
      .add,
      collection: _collection,
      model: newModel,
      coverVideo: coverVideo,
    );
    EditBingePage._logger.info('series saved $seryModel');
    final localContext = context;
    if (localContext.mounted) {
      while (localContext.canPop()) {
        localContext.pop();
      }
      localContext.goNamed(Pages.myShows.name);
    }
  }
}
