import 'package:bingetube/core/constants/assets.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ListScreenWidget extends StatefulWidget {
  final bool isSystem;
  const ListScreenWidget({super.key, required this.isSystem});

  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget> {
  late BingeDao _bingeDao;

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
        return ListView.builder(
          itemCount: collections.length,
          itemBuilder: (c, i) => _buildCollection(c, collections[i]),
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
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8.0, left: 8.0),
      child: Column(
        children: [
          Align(
            alignment: .centerLeft,
            child: Text(
              model.collection.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: .horizontal,
              itemCount: model.series.length,
              itemBuilder: (c, i) => _buildSery(c, model.series[i]),
              separatorBuilder: (c, i) => SizedBox(width: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSery(BuildContext context, SeryModel model) {
    final heroId = model.sery.id.toString();
    final heroImg = model.thumbnail.mediumUrl;
    return Material(
      child: InkWell(
        onTap: () => _onTapSery(context, model, heroId, heroImg),
        child: Row(
          children: [
            Hero(
              tag: heroId,
              child: Image.network(
                heroImg,
                width: 160,
                height: 90,
                fit: .cover,
              ),
            ),
          ],
        ),
      ),
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
}
