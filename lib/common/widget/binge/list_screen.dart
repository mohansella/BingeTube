import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/constants/assets.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/core/db/port/sery_port.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';

class ListScreenWidget extends StatefulWidget {
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

  int _droppingOnSeryId = -1;
  bool _droppingOnLeft = true;

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
  }

  @override
  void didUpdateWidget(covariant ListScreenWidget oldWidget) {
    _droppingOnSeryId = -1;
    _droppingOnLeft = true;
    super.didUpdateWidget(oldWidget);
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
      formats: [Formats.fileUri],
      onDropEnter: (event) {
        setState(() {
          final seryId = event.session.items.first.localData as int;
          if (seryId == model.sery.id) {
            _droppingOnSeryId = -1;
          } else {
            _droppingOnSeryId = model.sery.id;
          }
        });
      },
      onDropLeave: (event) {
        setState(() {
          _droppingOnSeryId = -1;
        });
      },
      onDropOver: (event) {
        final seryId = event.session.items.first.localData as int;
        if (seryId == model.sery.id) {
          return DropOperation.none;
        } else {
          final pos = event.position.local.dx - (_width / 2);
          if (pos < 0 != _droppingOnLeft) {
            setState(() {
              _droppingOnLeft = pos < 0;
            });
          }
          return DropOperation.move;
        }
      },
      onPerformDrop: (event) async {
        final seryId = event.session.items.first.localData as int;
        final pos = event.position.local.dx - (_width / 2);
        final targetPriority = model.sery.priority;
        final priority = pos < 0 ? targetPriority : targetPriority + 1;
        final collectionId = model.sery.collectionId;
        await BingeDao(Database()).moveSery(
          seryId: seryId,
          collectionId: collectionId,
          priority: priority,
        );
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
        final tempFile = await SeryPort.exportToTempDirectory(model.sery.id);
        final fileName = '${path.basename(tempFile.path)}.binge';
        final item = DragItem(
          suggestedName: fileName,
          localData: model.sery.id,
        );
        item.add(Formats.fileUri(tempFile.uri));
        return item;
      },
      child: DraggableWidget(
        child: Material(
          child: InkWell(
            onTap: () => _onTapSery(context, model, heroId, heroImg),
            child: Hero(
              tag: heroId,
              child: Transform.translate(
                offset: Offset(dropShift, 0.0),
                child: _buildSeryImage(heroImg, model),
              ),
            ),
          ),
        ),
      ),
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
}
