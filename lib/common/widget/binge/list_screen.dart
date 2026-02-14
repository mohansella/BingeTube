import 'dart:convert';
import 'dart:io';

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
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';

class ListScreenWidget extends StatefulWidget {
  static final _logger = LogManager.getLogger('ListScreenWidget');

  final bool isSystem;
  const ListScreenWidget({super.key, required this.isSystem});

  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget> {
  late BingeDao _bingeDao;
  static const double minWidth = 160;
  double _width = 0;
  double _height = 0;

  late int _droppingOnSeryId;
  late bool _droppingOnLeft;
  late int _dropCollectionId;
  late int _dropPriority;

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
    _initDropState();
  }

  @override
  void didUpdateWidget(covariant ListScreenWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initDropState();
  }

  void _initDropState() {
    _droppingOnSeryId = -1;
    _droppingOnLeft = false;
    _dropCollectionId = -1;
    _dropPriority = -1;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bingeDao.streamCollectionModels(isSystem: widget.isSystem),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final collections = snapshot.data!;
        if (collections.isEmpty) {
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
              itemBuilder: (c, i) => _buildCollection(c, collections[i]),
            );
          },
        );
      },
    );
  }

  Widget _buildCollectionEmpty() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.7,
                height: constraints.maxHeight * 0.7,
                child: Lottie.asset(Assets.emptyBox.path, fit: BoxFit.contain),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'No collections found. Add one via search, copy, or import.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollection(BuildContext context, CollectionModel model) {
    final titleStyle = Theme.of(context).textTheme.bodyMedium;
    final ratio = _width / minWidth;
    final oFontSize = (titleStyle?.fontSize ?? 0);
    var fontSize = oFontSize * ratio * 0.85;
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
              style: titleStyle?.copyWith(fontSize: fontSize),
            ),
          ),
          SizedBox(height: 4 * ratio),
          SizedBox(
            height: _height,
            child: ListView.separated(
              scrollDirection: .horizontal,
              itemCount: model.series.length,
              itemBuilder: (_, i) => _buildSery(model.series[i]),
              separatorBuilder: (_, _) => SizedBox(width: 4 * ratio),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSery(SeryModel model) {
    return _buildDropRegion(model, _buildDragItem(model));
  }

  DropRegion _buildDropRegion(SeryModel model, Widget child) {
    return DropRegion(
      formats: [Formats.fileUri, Formats.htmlFile],
      onDropEnter: (event) {
        setState(() {
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
          _droppingOnSeryId = -1;
        });
      },
      onDropOver: (event) {
        final item = event.session.items.first;
        final isLocalData = item.localData != null;
        if (isLocalData) {
          final seryId = item.localData as int;
          if (seryId == model.sery.id) {
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
        final targetPriority = model.sery.priority;
        final priority = pos < 0 ? targetPriority : targetPriority + 1;
        final collectionId = model.sery.collectionId;

        if (item.localData == null) {
          _dropCollectionId = collectionId;
          _dropPriority = priority;
          await _performDropsFromExternal(event);
        } else {
          final seryId = item.localData as int;
          await BingeDao(Database()).moveSery(
            seryId: seryId,
            collectionId: collectionId,
            priority: priority,
          );
        }
      },
      child: child,
    );
  }

  DragItemWidget _buildDragItem(SeryModel model) {
    final heroId = model.sery.id.toString();
    final heroImg = model.thumbnail.mediumUrl;
    double dropShift = model.sery.id == _droppingOnSeryId ? 20 : 0;
    dropShift = _droppingOnLeft ? dropShift : -dropShift;

    return DragItemWidget(
      allowedOperations: () => [DropOperation.move, DropOperation.copy],
      dragItemProvider: (request) async {
        final fileBaseName = FileUtils.toSlugFileName(model.sery.name);
        final fileName = '$fileBaseName.binge';
        final item = DragItem(
          suggestedName: fileName,
          localData: model.sery.id,
        );
        await _addVirtualFile(item, model);
        return item;
      },
      child: DraggableWidget(
        child: Material(
          child: InkWell(
            onTap: () => _onTapSery(context, model, heroId, heroImg),
            child: Transform.translate(
              offset: Offset(dropShift, 0.0),
              child: _buildActualSery(heroId, heroImg, model),
            ),
          ),
        ),
      ),
    );
  }

  Hero _buildActualSery(String heroId, String heroImg, SeryModel model) {
    return Hero(tag: heroId, child: _buildSeryImage(heroImg, model));
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
        return _buildSeryImageFallback(
          c,
          model,
          height: _height,
          width: _width,
        );
      },
      errorBuilder: (c, _, _) =>
          _buildSeryImageFallback(c, model, height: _height, width: _width),
    );
  }

  void _onTapSery(
    BuildContext context,
    SeryModel model,
    String heroId,
    String heroImg,
  ) {
    context.pushNamed(
      Pages.binge.name,
      queryParameters: BingePage.buildParams(
        type: .seryVideos,
        id: model.sery.id.toString(),
        videoId: model.thumbnail.id,
        heroId: heroId,
        heroImg: heroImg,
      ),
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

    ListScreenWidget._logger.info(
      'Dropped file: $fileName Size:$fileSize bytes',
    );

    final bytes = await file.readAll();
    final value = utf8.decode(bytes);
    final json = jsonDecode(value);
    if (_dropCollectionId == -1 || _dropPriority == -1) {
      throw Exception('invalid state');
    }
    await SeryPort.importAsJson(json, _dropCollectionId, _dropPriority);
  }

  void _importError(Object error) {
    ListScreenWidget._logger.warning('Error reading file', error);
  }
}
