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

class _ListScreenWidgetState extends State<ListScreenWidget>
    with SingleTickerProviderStateMixin {
  static const double minWidth = 160;

  late CollectionsRepo _collectionsRepo;
  late SeriesRepo _seriesRepo;
  late AnimationController _lottieController;
  double _width = 0;
  double _height = 0;

  late bool _droppingOnEmpty;
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
        return LayoutBuilder(
          builder: (context, constraints) {
            _width = constraints.maxWidth / 5.2;
            if (_width < minWidth) {
              _width = minWidth;
            }
            _height = _width * 9.0 / 16.0;
            return ListView.builder(
              itemCount: collections.length,
              itemBuilder: (c, i) => _buildCollection(collections[i]),
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

  Widget _buildCollection(CollectionModel model) {
    final titleStyle = Theme.of(context).textTheme.bodyMedium;
    final ratio = _width / minWidth;
    final oFontSize = (titleStyle?.fontSize ?? 0);
    var fontSize = oFontSize * ratio * 0.90;
    if (fontSize < oFontSize) {
      fontSize = oFontSize;
    }
    final padding = 8 * ratio;
    return Padding(
      padding: EdgeInsets.only(top: padding, bottom: padding, left: padding),
      child: Column(
        children: [
          Align(
            alignment: .centerLeft,
            child: Text(
              model.collection.name,
              style: titleStyle?.copyWith(fontSize: fontSize, fontWeight: .w500),
            ),
          ),
          SizedBox(height: 4 * ratio),
          SizedBox(
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

  Widget _buildSery(CollectionModel collection, SeryModel model) {
    return _buildDropRegion(model: model, child: _buildDragItem(collection, model));
  }

  DropRegion _buildDropRegion({SeryModel? model, required Widget child}) {
    return DropRegion(
      formats: [Formats.fileUri, Formats.htmlFile],
      onDropEnter: (event) {
        setState(() {
          if (model == null) {
            _droppingOnEmpty = true;
            _lottieController.stop(canceled: false);
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
        final priority = pos < 0 ? targetPriority : targetPriority + 1;

        final bingeDao = BingeDao(Database());
        final collectionId =
            model?.sery.collectionId ?? (await bingeDao.getDefaultCollection()).id;

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
      },
      child: child,
    );
  }

  DragItemWidget _buildDragItem(CollectionModel collection, SeryModel model) {
    final heroId = widget.isSystem ? model.dataPath! : model.sery.id.toString();
    final heroImg = model.coverUrl;
    double dropShift = model.sery.id == _droppingOnSeryId ? 20 : 0;
    dropShift = _droppingOnLeft ? dropShift : -dropShift;

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
            onTap: () => _onTapSery(context, collection, model, heroId, heroImg),
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
    var id = model.sery.id.toString();
    if (widget.isSystem) {
      if (!model.isSaved) {
        final sery = await _downloadSery(collection, model);
        if (sery == null) return;
        id = sery.id.toString();
      } else if (model.dataHash != model.sery.dataHash) {
        ListScreenWidget._logger.info('updating sery:${model.sery.name}');
        final sery = await _updateSery(collection, model);
        if (sery == null) return;
        id = sery.id.toString();
      } else {
        ListScreenWidget._logger.info('opening sery:${model.sery.name}');
      }
    }
    if (!context.mounted) return;
    context.pushNamed(
      Pages.binge.name,
      queryParameters: BingePage.buildParams(
        type: .seryVideos,
        id: id,
        videoId: model.sery.coverVideoId,
        heroId: heroId,
        heroImg: heroImg,
      ),
    );
  }

  Future<Sery?> _downloadSery(CollectionModel collection, SeryModel model) async {
    ListScreenWidget._logger.info('saving sery:${model.sery.name}');
    final isCancelled = Mutable(false);
    CustomDialog.show(
      context,
      'Downloading ${model.sery.name}',
      'Cancel',
      Row(mainAxisAlignment: .center, children: [CircularProgressIndicator()]),
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
      'Updating ${model.sery.name}',
      'Cancel',
      Row(mainAxisAlignment: .center, children: [CircularProgressIndicator()]),
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
}
