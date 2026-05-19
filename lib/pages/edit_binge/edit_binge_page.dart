import 'dart:math' as math;
import 'package:bingetube/app/routes.dart';
import 'package:bingetube/common/widget/binge/binge_video_entry.dart';
import 'package:bingetube/common/widget/binge/choose_collection.dart';
import 'package:bingetube/common/widget/binge/choose_sery.dart';
import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/common/widget/refine/refine_widget.dart';
import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      [BingeParams.type, BingeParams.id].map((v) => MapEntry(v.name, params[v.name]!)),
    );
  }

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .editBinge,
      customBuilder: (_, s) => EditBingePage(s.uri.queryParameters),
    );
  }
}

class _EditBingePageState extends ConsumerState<EditBingePage> {
  final Set<String> _checkMarked = {};
  final List<String> _sortOrder = [];
  late List<VideoModel> _filteredVideos;
  String? _lastToggledVideoId;

  bool _isLoading = true;
  bool _showTitle = false;
  bool _isOrderModified = false;
  late BingeModel _unfilteredModel;
  late BingeDao _bingeDao;
  late Collection _collection;

  late BingeController _controller;
  TextEditingController? _editTitleController;
  TextEditingController? _editDescriptionController;

  bool get _isDrag => _controller.filter == BingeFilter.defaultValue;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
    _bingeDao = BingeDao(Database());
    initAsync();
  }

  void initAsync() async {
    final model = await _controller.stream.first;
    final collection = model.collectionId == null
        ? await _bingeDao.getInitialCollectionForNewSeries()
        : await _bingeDao.getCollection(model.collectionId!);
    _isLoading = false;
    _unfilteredModel = model;
    _collection = collection;
    _resetOrder();
    for (var v in _unfilteredModel.videos) {
      _check(v.video.id, true);
    }
    setState(() {});
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
          return Scaffold(
            body: SafeArea(
              child: _buildStateView(
                icon: Icons.playlist_play_outlined,
                title: 'Loading playlist entries',
                message: 'Getting this binge ready for editing.',
                isLoading: true,
              ),
            ),
          );
        }
        final model = snashot.data!;
        _filteredVideos = model.videos;
        if (_isDrag) {
          final idVsVideos = Map.fromEntries(
            _filteredVideos.map((v) => MapEntry(v.video.id, v)),
          );
          _filteredVideos = _sortOrder.map((id) => idVsVideos[id]!).toList();
        }
        return Scaffold(
          appBar: _buildAppBar(context, _filteredVideos),
          body: _buildList(_filteredVideos),
        );
      },
    );
  }

  Widget _buildList(List<VideoModel> videos) {
    if (videos.isEmpty) {
      return _buildStateView(
        icon: Icons.playlist_remove_outlined,
        title: 'No playlist entries',
        message: 'Adjust the filters or select another binge to edit.',
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
      itemBuilder: (context, i) => _buildVideoCard(videos[i], i),
      itemCount: videos.length,
      onReorder: _onReorder,
      buildDefaultDragHandles: false,
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final value = Curves.easeOut.transform(animation.value);
            return Transform.scale(
              scale: 1 + value * 0.015,
              child: Material(
                color: Colors.transparent,
                elevation: 8 * value,
                borderRadius: BorderRadius.circular(8),
                child: child,
              ),
            );
          },
          child: child,
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, List<VideoModel> filteredVideos) {
    return AppBar(
      toolbarHeight: 64,
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
        preferredSize: Size.fromHeight(_showTitle ? 228 : 58),
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
    final theme = Theme.of(context);
    _editTitleController ??= TextEditingController(text: model.title);
    _editDescriptionController ??= TextEditingController(text: model.description);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: 'Choose Collection',
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: _chooseCollection,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _collection.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 1,
                autofocus: true,
                controller: _editTitleController,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Binge title',
                  prefixIcon: const Icon(Icons.title, size: 18),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 1,
                controller: _editDescriptionController,
                style: theme.textTheme.bodySmall,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Description',
                  prefixIcon: const Icon(Icons.subject, size: 18),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStateView({
    required IconData icon,
    required String title,
    required String message,
    bool isLoading = false,
  }) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 96),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    )
                  : Icon(icon, size: 30, color: theme.colorScheme.onSecondaryContainer),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, List<VideoModel> filteredVideos) {
    final theme = Theme.of(context);
    final model = _unfilteredModel;
    String subtitle;
    String prefix;
    if (_controller.filter == BingeFilter.defaultValue) {
      subtitle = '${model.videos.length} playlist entries';
    } else {
      subtitle = 'Showing ${filteredVideos.length} of ${model.videos.length} entries';
    }
    if (_checkMarked.isEmpty) {
      prefix = '';
    } else {
      prefix = '${_checkMarked.length} selected - ';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit Binge',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 3),
        Text(
          '$prefix$subtitle',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarBottom(List<VideoModel> filteredVideos) {
    if (_unfilteredModel.videos.isEmpty) {
      return const SizedBox(height: 50);
    }

    final isAllSelected =
        filteredVideos.isNotEmpty &&
        filteredVideos.every((v) => _checkMarked.contains(v.video.id));
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 16, 8),
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
              icon: Icon(isAllSelected ? Icons.check_box_outline_blank : Icons.done_all),
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
    return Padding(
      key: ValueKey(video.video.id),
      padding: const EdgeInsets.only(bottom: 8),
      child: BingeVideoEntry(
        video: video,
        position: index + 1,
        isSelected: isChecked,
        showSelection: true,
        isDragEnabled: _isDrag,
        dragIndex: index,
        onTap: () => _onToggleTap(video),
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
    final sort = _controller.sort;
    List<VideoModel> sortedVideos;
    if (sort.sortType == .system) {
      if (sort.sortOrder == .asc) {
        sortedVideos = [..._unfilteredModel.videos];
      } else {
        sortedVideos = [..._unfilteredModel.videos].reversed.toList();
      }
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
      title: 'Save to collection',
    );
    if (chosenCollection == null) {
      return;
    }
    setState(() {
      _collection = chosenCollection;
    });
  }

  void _onCopyPressed() async {
    final chosenSery = await ChooseSeryWidget.showChooseSeries(
      context,
      title: 'Copy to series',
    );
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
    await _bingeDao.addVideos(chosenSery.id, sourceList, targetModel.videos.length);
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
    final description = _editDescriptionController?.text ?? _unfilteredModel.description;
    final idVsVideoEntries = _unfilteredModel.videos.map((v) => MapEntry(v.video.id, v));
    final idVsVideos = Map.fromEntries(idVsVideoEntries);
    final videos = _sortOrder.map((id) => idVsVideos[id]!).toList();
    videos.removeWhere((v) => !_checkMarked.contains(v.video.id));
    final newModel = BingeModel(
      title: title,
      description: description,
      videos: videos,
      collectionId: _collection.id,
      priority: _unfilteredModel.priority,
    );

    final actions = await _controller.supportedActions();
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
      localContext.goNamed(Pages.library.name);
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
      localContext.goNamed(Pages.library.name);
    }
  }

  void _onToggleTap(VideoModel model) {
    final id = model.video.id;
    final isChecked = _checkMarked.contains(id);
    final isShift =
        HardwareKeyboard.instance.logicalKeysPressed.contains(
          LogicalKeyboardKey.shiftLeft,
        ) ||
        HardwareKeyboard.instance.logicalKeysPressed.contains(
          LogicalKeyboardKey.shiftRight,
        );

    //invalid last id if not in filtered list
    final ids = _filteredVideos.map((v) => v.video.id).toList();
    if (_lastToggledVideoId != null) {
      final lastId = ids.firstWhere((id) => id == _lastToggledVideoId, orElse: () => '');
      if (lastId.isEmpty) {
        _lastToggledVideoId = null;
      }
    }

    if (isShift && _lastToggledVideoId != null) {
      final isPrevChecked = _checkMarked.contains(_lastToggledVideoId!);
      final prevPos = ids.indexOf(_lastToggledVideoId!);
      final currPos = ids.indexOf(id);
      final startPos = math.min(prevPos, currPos);
      final endPos = math.max(prevPos, currPos);
      ids.sublist(startPos, endPos + 1).forEach((i) => _check(i, isPrevChecked));
    } else {
      _check(id, !isChecked);
    }
    _lastToggledVideoId = id;
    setState(() {});
  }

  void _check(String id, bool isCheck) {
    if (isCheck) {
      _checkMarked.add(id);
    } else {
      _checkMarked.remove(id);
    }
  }
}
