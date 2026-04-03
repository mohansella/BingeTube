import 'package:bingetube/app/routes.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/repo/collections_repo.dart';
import 'package:bingetube/core/db/repo/series_repo.dart';
import 'package:bingetube/core/lang/mutable.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class SeriesPage extends ConsumerStatefulWidget {
  final String slug;
  const SeriesPage(this.slug, {super.key});

  @override
  ConsumerState<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends ConsumerState<SeriesPage> {
  String _loadingText = 'Loading...';
  final _isCancelled = Mutable(false);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final collectionsRepo = CollectionsRepo(isSystem: true);
    final seriesRepo = SeriesRepo(isSystem: true);
    final collections = await collectionsRepo.streamCollections().first;
    final slug = '${widget.slug.substring(1)}.binge';
    final model = collections
        .expand((c) => c.series)
        .firstWhere((s) => s.dataPath == slug);
    final collection = collections.firstWhere((c) => c.series.contains(model));
    Sery? sery = model.sery;
    if (!model.isSaved) {
      setState(() {
        _loadingText = 'Downloading ${model.sery.name}';
      });
      sery = await seriesRepo.downloadSery(_isCancelled, collection, model);
    } else if (model.dataHash != model.sery.dataHash) {
      setState(() {
        _loadingText = 'Updating ${model.sery.name}';
      });
      sery = await seriesRepo.updateSery(_isCancelled, collection, model);
    }
    final lContext = context;
    if (!lContext.mounted) {
      return;
    }
    if (sery == null) {
      Routes.popOrHome(lContext);
    } else {
      final heroId = model.dataPath!;
      final heroImg = model.coverUrl;
      lContext.replaceNamed(
        Pages.binge.name,
        queryParameters: BingePage.buildParams(
          type: .seryVideos,
          id: sery.id.toString(),
          videoId: model.sery.coverVideoId,
          heroId: heroId,
          heroImg: heroImg,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(_loadingText),
            SizedBox(height: 16),
            CircularProgressIndicator(),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Routes.popOrHome(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
