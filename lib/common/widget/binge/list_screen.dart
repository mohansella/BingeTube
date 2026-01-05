import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          return Center(
            child: Text(
              widget.isSystem
                  ? 'Work in progress'
                  : 'Collection is empty. Add more from search or import.',
            ),
          );
        }
        return ListView.builder(
          itemCount: collections.length,
          itemBuilder: (c, i) => _buildCollection(c, collections[i]),
        );
      },
    );
  }

  Widget _buildCollection(BuildContext context, CollectionModel model) {
    return Column(
      mainAxisAlignment: .start,
      children: [
        Text('${model.collection.name} (${model.series.length})'),
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
    );
  }

  Widget _buildSery(BuildContext context, SeryModel model) {
    final heroId = model.sery.id.toString();
    return Hero(
      tag: heroId,
      child: Material(
        child: InkWell(
          onTap: () => _onTapSery(context, model, heroId),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 160,
                child: Stack(
                  fit: .expand,
                  children: [
                    Image.network(model.thumbnail.highUrl, fit: BoxFit.cover),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSery(BuildContext context, SeryModel model, String heroId) {
    context.pushNamed(
      Pages.binge.name,
      queryParameters: BingePage.buildParams(
        type: .seryVideos,
        id: model.sery.id.toString(),
        videoId: model.thumbnail.id,
        heroId: heroId,
        heroImg: model.thumbnail.highUrl,
      ),
    );
  }
}
