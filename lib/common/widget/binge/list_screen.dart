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

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
  }

  @override
  void didUpdateWidget(covariant ListScreenWidget oldWidget) {
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
              itemBuilder: (c, i) => _buildSery(c, model.series[i]),
              separatorBuilder: (c, i) => SizedBox(width: 4 * ratio),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSery(BuildContext context, SeryModel model) {
    final heroId = model.sery.id.toString();
    final heroImg = model.thumbnail.mediumUrl;
    return DragItemWidget(
      allowedOperations: () => [DropOperation.copy],
      dragItemProvider: (request) async {
        final tempFile = await SeryPort.exportToTempDirectory(model.sery.id);
        final fileName = '${path.basename(tempFile.path)}.binge';
        final item = DragItem(suggestedName: fileName);
        item.add(Formats.fileUri(tempFile.uri));
        return item;
      },
      child: DraggableWidget(
        child: Material(
          child: InkWell(
            onTap: () => _onTapSery(context, model, heroId, heroImg),
            child: Hero(tag: heroId, child: _buildSeryImage(heroImg, model)),
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
        return _buildCoverFallback(c, model, height: _height, width: _width);
      },
      errorBuilder: (c, _, _) =>
          _buildCoverFallback(c, model, height: _height, width: _width),
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

  Widget _buildCoverFallback(
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
