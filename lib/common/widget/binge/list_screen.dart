import 'dart:io';

import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/db/repo/series_repo.dart';
import 'package:bingetube/core/lang/mutable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/file_utils.dart';
import 'package:bingetube/core/constants/assets.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/core/db/port/sery_port.dart';
import 'package:bingetube/core/db/repo/collections_repo.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';

class ListScreenWidget extends StatefulWidget {
  static final _logger = LogManager.getLogger('ListScreenWidget');

  final bool isSystem;
  const ListScreenWidget({super.key, required this.isSystem});

  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

enum _CollectionAction { moveUp, moveDown, rename, delete }

class _ListScreenWidgetState extends State<ListScreenWidget>
    with SingleTickerProviderStateMixin {
  static const double minWidth = 160;

  late CollectionsRepo _collectionsRepo;
  late SeriesRepo _seriesRepo;
  late AnimationController _lottieController;
  double _width = 0;
  double _height = 0;

  late bool _droppingOnEmpty;
  late int _droppingOnCollectionId;
  late int _droppingOnSeryId;
  late bool _droppingOnLeft;
  late int _dropCollectionId;
  late int _dropPriority;

  @override
  void initState() {
    super.initState();
    _collectionsRepo = CollectionsRepo(isSystem: widget.isSystem);
    _seriesRepo = SeriesRepo(isSystem: widget.isSystem);
    _lottieController = AnimationController(vsync: this);
    _initDropState();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ListScreenWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initDropState();
  }

  void _initDropState() {
    _droppingOnEmpty = false;
    _droppingOnCollectionId = -1;
    _droppingOnSeryId = -1;
    _droppingOnLeft = false;
    _dropCollectionId = -1;
    _dropPriority = -1;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _collectionsRepo.streamCollections(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          ListScreenWidget._logger.warning('error: ${snapshot.error}');
          ListScreenWidget._logger.warning('stack: ${snapshot.stackTrace}');
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final collections = snapshot.data!;
        if (collections.isEmpty) {
          if (widget.isSystem) {
            return _buildSystemEmpty();
          } else {
            return _buildCollectionEmpty();
          }
        }
        if (!widget.isSystem && collections.every((c) => c.series.isEmpty)) {
          return _buildCollectionEmpty();
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            _width = constraints.maxWidth / 5.2;
            if (_width < minWidth) {
              _width = minWidth;
            }
            _height = _width * 9.0 / 16.0;
            return ListView.builder(
              itemCount: collections.length,
              itemBuilder: (c, i) => _buildCollection(collections, i),
            );
          },
        );
      },
    );
  }

  Widget _buildSystemEmpty() {
    return const Center(
      child: Text(
        'Beta version — predefined collections coming soon.',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCollectionEmpty() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: _buildDropRegion(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.7,
                  height: constraints.maxHeight * 0.7,
                  child: Lottie.asset(
                    Assets.emptyBox.path,
                    fit: BoxFit.contain,
                    controller: _lottieController,
                    onLoaded: (composition) {
                      _lottieController
                        ..duration = composition.duration
                        ..forward()
                        ..repeat();
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'No collections yet. Search, copy from Home, or drop a binge file to get started.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollection(List<CollectionModel> collections, int index) {
    final model = collections[index];
    final titleStyle = Theme.of(context).textTheme.bodyMedium;
    final ratio = _width / minWidth;
    final oFontSize = (titleStyle?.fontSize ?? 0);
    var fontSize = oFontSize * ratio * 0.90;
    if (fontSize < oFontSize) {
      fontSize = oFontSize;
    }
    final padding = 8 * ratio;
    return Padding(
      key: ValueKey(model.collection.id),
      padding: EdgeInsets.only(top: padding, bottom: padding, left: padding),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: padding),
            child: _buildCollectionHeader(
              collections: collections,
              index: index,
              model: model,
              titleStyle: titleStyle,
              fontSize: fontSize,
            ),
          ),
          SizedBox(height: 4 * ratio),
          model.series.isEmpty
              ? _buildEmptyCollectionDropTarget(model, ratio)
              : SizedBox(
                  height: _height,
                  child: ListView.separated(
                    scrollDirection: .horizontal,
                    itemCount: model.series.length,
                    itemBuilder: (_, i) => _buildSery(model, model.series[i]),
                    separatorBuilder: (_, _) => SizedBox(width: 4 * ratio),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildCollectionHeader({
    required List<CollectionModel> collections,
    required int index,
    required CollectionModel model,
    required TextStyle? titleStyle,
    required double fontSize,
  }) {
    final theme = Theme.of(context);
    final seriesCount = model.series.length;
    final accentColor = Themes.colorFromId(
      model.collection.name,
      theme.brightness,
      sat: 0.48,
      light: 0.58,
      dark: 0.48,
    );
    return Row(
      children: [
        Container(
          width: 4,
          height: fontSize * 1.45,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            model.collection.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titleStyle?.copyWith(fontSize: fontSize, fontWeight: .w500),
          ),
        ),
        if (!widget.isSystem) ...[
          const SizedBox(width: 8),
          Text(
            '$seriesCount series',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          PopupMenuButton<_CollectionAction>(
            tooltip: 'Collection actions',
            onSelected: (action) => _onCollectionAction(
              action,
              collections: collections,
              index: index,
              model: model,
            ),
            itemBuilder: (context) => [
              _buildCollectionMenuItem(
                context,
                action: _CollectionAction.moveUp,
                icon: Icons.keyboard_arrow_up,
                label: 'Move up',
                enabled: index > 0,
              ),
              _buildCollectionMenuItem(
                context,
                action: _CollectionAction.moveDown,
                icon: Icons.keyboard_arrow_down,
                label: 'Move down',
                enabled: index < collections.length - 1,
              ),
              const PopupMenuDivider(),
              _buildCollectionMenuItem(
                context,
                action: _CollectionAction.rename,
                icon: Icons.edit_outlined,
                label: 'Rename',
              ),
              _buildCollectionMenuItem(
                context,
                action: _CollectionAction.delete,
                icon: Icons.delete_outline,
                label: 'Delete',
                destructive: true,
              ),
            ],
          ),
        ],
      ],
    );
  }

  PopupMenuEntry<_CollectionAction> _buildCollectionMenuItem(
    BuildContext context, {
    required _CollectionAction action,
    required IconData icon,
    required String label,
    bool enabled = true,
    bool destructive = false,
  }) {
    final theme = Theme.of(context);
    final color = enabled
        ? destructive
              ? theme.colorScheme.error
              : null
        : theme.disabledColor;
    return PopupMenuItem<_CollectionAction>(
      value: action,
      enabled: enabled,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildEmptyCollectionDropTarget(CollectionModel model, double ratio) {
    final theme = Theme.of(context);
    final isDropping = _droppingOnCollectionId == model.collection.id;
    final color = isDropping
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: _height,
        child: _buildDropRegion(
          collection: model,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: _width,
            height: _height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4 * ratio),
              border: Border.all(color: color.withAlpha(isDropping ? 210 : 90)),
              color: isDropping
                  ? theme.colorScheme.primaryContainer.withAlpha(80)
                  : theme.colorScheme.surfaceContainerHighest.withAlpha(80),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.playlist_add, color: color),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Drop series here',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(color: color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onCollectionAction(
    _CollectionAction action, {
    required List<CollectionModel> collections,
    required int index,
    required CollectionModel model,
  }) async {
    switch (action) {
      case _CollectionAction.moveUp:
        return _moveCollection(collections, index, index - 1);
      case _CollectionAction.moveDown:
        return _moveCollection(collections, index, index + 1);
      case _CollectionAction.rename:
        return _renameCollection(model.collection);
      case _CollectionAction.delete:
        return _deleteCollection(model);
    }
  }

  Future<void> _moveCollection(
    List<CollectionModel> collections,
    int oldIndex,
    int newIndex,
  ) async {
    if (newIndex < 0 || newIndex >= collections.length || oldIndex == newIndex) {
      return;
    }
    final orderedIds = collections.map((c) => c.collection.id).toList();
    final moved = orderedIds.removeAt(oldIndex);
    orderedIds.insert(newIndex, moved);
    await BingeDao(Database()).reorderCollections(orderedIds);
  }

  Future<void> _renameCollection(Collection collection) async {
    final controller = TextEditingController(text: collection.name);
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
    final newName = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Rename collection'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Collection name'),
            onSubmitted: (value) => Navigator.of(dialogContext).pop(value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    controller.dispose();
    final trimmedName = newName?.trim();
    if (trimmedName == null || trimmedName.isEmpty || trimmedName == collection.name) {
      return;
    }
    await BingeDao(Database()).updateCollection(collection.id, name: trimmedName);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Renamed to $trimmedName')));
  }

  Future<void> _deleteCollection(CollectionModel model) async {
    final seriesCount = model.series.length;
    final confirmed = await CustomDialog.show(
      context,
      'Delete ${model.collection.name}?',
      'Delete',
      Text('This removes the collection and $seriesCount series from your library.'),
      cancelText: 'Cancel',
    );
    if (!confirmed) {
      return;
    }
    await BingeDao(Database()).deleteCollection(model.collection.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Deleted ${model.collection.name}')));
  }

  Widget _buildSery(CollectionModel collection, SeryModel model) {
    return _buildDropRegion(model: model, child: _buildDragItem(collection, model));
  }

  DropRegion _buildDropRegion({
    CollectionModel? collection,
    SeryModel? model,
    required Widget child,
  }) {
    return DropRegion(
      formats: [Formats.fileUri, Formats.htmlFile],
      onDropEnter: (event) {
        setState(() {
          if (model == null) {
            _droppingOnCollectionId = collection?.collection.id ?? -1;
            _droppingOnEmpty = collection == null;
            if (_droppingOnEmpty) {
              _lottieController.stop(canceled: false);
            }
            return;
          }
          final item = event.session.items.first;
          if (item.localData != null) {
            final seryId = item.localData as int;
            if (seryId == model.sery.id) {
              _droppingOnSeryId = -1;
              return;
            }
          }
          _droppingOnSeryId = model.sery.id;
        });
      },
      onDropLeave: (event) {
        setState(() {
          _droppingOnCollectionId = -1;
          if (_droppingOnEmpty) {
            _droppingOnEmpty = false;
            _lottieController.forward();
          }
          _droppingOnSeryId = -1;
        });
      },
      onDropOver: (event) {
        if (widget.isSystem) {
          return DropOperation.none;
        }
        final item = event.session.items.first;
        final isLocalData = item.localData != null;
        if (isLocalData) {
          final seryId = item.localData as int;
          if (model != null && seryId == model.sery.id) {
            return DropOperation.none;
          }
        }
        final pos = event.position.local.dx - (_width / 2);
        setState(() {
          _droppingOnLeft = pos < 0;
        });
        return isLocalData ? DropOperation.move : DropOperation.copy;
      },
      onPerformDrop: (event) async {
        final item = event.session.items.first;
        final pos = event.position.local.dx - (_width / 2);
        final targetPriority = model?.sery.priority ?? 1;
        final priority = model == null
            ? 1
            : pos < 0
            ? targetPriority
            : targetPriority + 1;

        final bingeDao = BingeDao(Database());
        final collectionId =
            model?.sery.collectionId ??
            collection?.collection.id ??
            (await bingeDao.getDefaultCollection()).id;

        if (item.localData == null) {
          _dropCollectionId = collectionId;
          _dropPriority = priority;
          await _performDropsFromExternal(event);
        } else {
          final seryId = item.localData as int;
          await bingeDao.shiftSery(
            seryId: seryId,
            collectionId: collectionId,
            priority: priority,
          );
        }
        if (!mounted) {
          return;
        }
        setState(_initDropState);
      },
      child: child,
    );
  }

  DragItemWidget _buildDragItem(CollectionModel collection, SeryModel model) {
    final heroId = widget.isSystem ? model.dataPath! : model.sery.id.toString();
    final heroImg = model.coverUrl;
    double dropShift = model.sery.id == _droppingOnSeryId ? 20 : 0;
    dropShift = _droppingOnLeft ? dropShift : -dropShift;

    Future<void> onTap() => _onTapSery(context, collection, model, heroId, heroImg);
    return DragItemWidget(
      allowedOperations: () =>
          widget.isSystem ? [] : [DropOperation.move, DropOperation.copy],
      dragItemProvider: (request) async {
        final fileBaseName = FileUtils.toSlugFileName(model.sery.name);
        final fileName = '$fileBaseName.binge';
        final item = DragItem(suggestedName: fileName, localData: model.sery.id);
        await _addVirtualFile(item, model);
        return item;
      },
      child: DraggableWidget(
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: Transform.translate(
              offset: Offset(dropShift, 0.0),
              child: _buildActualSery(heroId, heroImg, model),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActualSery(String heroId, String heroImg, SeryModel model) {
    final ratio = _width / minWidth;
    final totalCount = model.totalVideos;
    final viewedCount = model.watchedVideos;
    final channelUrl = model.iconUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(4 * ratio),
      child: Stack(
        children: [
          Hero(tag: heroId, child: _buildSeryImage(heroImg, model)),
          _buildSeryBottomGradient(ratio),
          _buildSeryTopRightCount(ratio, totalCount),
          _buildSeryIconTitle(ratio, channelUrl, model),
          if (viewedCount > 0) _buildSeryProgress(viewedCount, totalCount, ratio),
        ],
      ),
    );
  }

  Positioned _buildSeryProgress(int viewedCount, int totalCount, double ratio) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: LinearProgressIndicator(
        value: viewedCount / totalCount,
        minHeight: 3 * ratio,
        backgroundColor: Colors.white.withAlpha(50),
        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
      ),
    );
  }

  Positioned _buildSeryIconTitle(double ratio, String channelUrl, SeryModel model) {
    return Positioned(
      left: 8 * ratio,
      bottom: 10 * ratio,
      right: 8 * ratio,
      child: Row(
        children: [
          Container(
            width: 18 * ratio,
            height: 18 * ratio,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: ClipOval(child: Image.network(channelUrl, fit: BoxFit.cover)),
          ),
          SizedBox(width: 6 * ratio),

          Expanded(
            child: Text(
              model.sery.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12 * ratio,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildSeryTopRightCount(double ratio, int totalCount) {
    return Positioned(
      top: 6 * ratio,
      right: 6 * ratio,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4 * ratio, vertical: 2 * ratio),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(190),
          borderRadius: BorderRadius.circular(3 * ratio),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow, size: 10 * ratio, color: Colors.white),
            SizedBox(width: 2 * ratio),
            Text(
              '$totalCount',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8 * ratio,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildSeryBottomGradient(double ratio) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 80 * ratio,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.0, 0.5],
              colors: [Colors.black.withAlpha(210), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addVirtualFile(DragItem item, SeryModel model) async {
    final seryId = model.sery.id;
    if (kIsWeb) {
      return;
    }
    return item.addVirtualFile(
      format: Formats.json,
      provider: (sinkProvider, progress) async {
        try {
          final tempFile = await SeryPort.exportToTempDirectory(seryId);
          final file = File(tempFile.path);
          final size = await file.length();

          final sink = sinkProvider(fileSize: size);
          final stream = file.openRead();
          await for (final chunk in stream) {
            sink.add(chunk);
          }
          sink.close();
        } catch (e) {
          ListScreenWidget._logger.warning('Virtual file error', e);
          sinkProvider(fileSize: 0).close();
        }
      },
    );
  }

  Image _buildSeryImage(String heroImg, SeryModel model) {
    return Image.network(
      heroImg,
      width: _width,
      height: _height,
      fit: .cover,
      frameBuilder: (c, child, frame, wasSyncLoaded) {
        if (frame != null || wasSyncLoaded) {
          return child;
        }
        return _buildSeryImageFallback(c, model, height: _height, width: _width);
      },
      errorBuilder: (c, _, _) =>
          _buildSeryImageFallback(c, model, height: _height, width: _width),
    );
  }

  Future<void> _onTapSery(
    BuildContext context,
    CollectionModel collection,
    SeryModel model,
    String heroId,
    String heroImg,
  ) async {
    if (widget.isSystem) {
      await _onTapSystemSery(context, collection, model);
    } else {
      context.pushNamed(
        Pages.binge.name,
        queryParameters: BingePage.buildParams(
          type: .seryVideos,
          id: model.sery.id.toString(),
          videoId: model.sery.coverVideoId,
          heroId: heroId,
          heroImg: heroImg,
        ),
      );
    }
  }

  Future<void> _onTapSystemSery(
    BuildContext context,
    CollectionModel collection,
    SeryModel model,
  ) async {
    Sery? sery = model.sery;
    if (!model.isSaved) {
      sery = await _downloadSery(collection, model);
    } else if (model.dataHash != model.sery.dataHash) {
      ListScreenWidget._logger.info('updating sery:${model.sery.name}');
      sery = await _updateSery(collection, model);
    } else {
      ListScreenWidget._logger.info('opening sery:${model.sery.name}');
    }
    if (sery == null) return;
    if (!context.mounted) return;
    final slug = _properDataPath(sery);
    context.pushNamed(Pages.series.name, pathParameters: {'slug': slug});
  }

  Future<Sery?> _downloadSery(CollectionModel collection, SeryModel model) async {
    ListScreenWidget._logger.info('saving sery:${model.sery.name}');
    final isCancelled = Mutable(false);
    CustomDialog.show(
      context,
      'Preparing ${model.sery.name}',
      'Cancel',
      _buildBingeLoadingContent('Initializing this binge for playback...'),
    ).then((v) {
      isCancelled.value = true;
    });

    final toReturn = await _seriesRepo.downloadSery(isCancelled, collection, model);
    final lContext = context;
    if (lContext.mounted && !isCancelled.value) {
      lContext.pop();
    }
    return toReturn;
  }

  Future<Sery?> _updateSery(CollectionModel collection, SeryModel model) async {
    ListScreenWidget._logger.info('updating sery:${model.sery.name}');
    final isCancelled = Mutable(false);
    CustomDialog.show(
      context,
      'Refreshing ${model.sery.name}',
      'Cancel',
      _buildBingeLoadingContent('Getting the latest binge details...'),
    ).then((v) {
      isCancelled.value = true;
    });

    final toReturn = await _seriesRepo.updateSery(isCancelled, collection, model);
    final lContext = context;
    if (lContext.mounted && !isCancelled.value) {
      lContext.pop();
    }
    return toReturn;
  }

  Widget _buildBingeLoadingContent(String message) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const LinearProgressIndicator(),
        const SizedBox(height: 14),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSeryImageFallback(
    BuildContext context,
    SeryModel model, {
    required double height,
    required double width,
  }) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(model.sery.coverVideoId, brightness);
    return Material(
      child: Container(
        color: color,
        height: height,
        width: width,
        alignment: .center,
        child: Text(model.sery.name),
      ),
    );
  }

  Future<void> _performDropsFromExternal(PerformDropEvent event) async {
    final items = event.session.items;
    ListScreenWidget._logger.info('dropped: ${items.length} items');
    for (final item in items) {
      await _performDropFromExternal(item);
    }
  }

  Future<void> _performDropFromExternal(DropItem item) async {
    final reader = item.dataReader!;
    ListScreenWidget._logger.info('supported format: ${item.platformFormats}');

    if (kIsWeb || reader.canProvide(Formats.fileUri)) {
      reader.getFile(null, _importFile, onError: _importError);
    }
  }

  Future<void> _importFile(DataReaderFile file) async {
    final fileName = file.fileName;
    final fileSize = file.fileSize;

    ListScreenWidget._logger.info('Dropped file: $fileName Size:$fileSize bytes');

    if (_dropCollectionId == -1 || _dropPriority == -1) {
      throw Exception('invalid state');
    }
    final zipBytes = await file.readAll();
    await SeryPort.import(
      zipBytes,
      collectionId: _dropCollectionId,
      priority: _dropPriority,
    );
  }

  void _importError(Object error) {
    ListScreenWidget._logger.warning('Error reading file', error);
  }

  String _properDataPath(Sery sery) {
    var toReturn = sery.dataPath!;
    final bingeSuffix = '.binge';
    if (!toReturn.startsWith('/')) {
      toReturn = '/$toReturn';
    }
    if (toReturn.endsWith(bingeSuffix)) {
      toReturn = toReturn.substring(0, toReturn.length - bingeSuffix.length);
    }
    return toReturn;
  }
}
