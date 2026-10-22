import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/core/db/repo/collections_repo.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContinueWatchingRow extends StatefulWidget {
  const ContinueWatchingRow({required this.discoverCollections, super.key});

  final List<CollectionModel> discoverCollections;

  @override
  State<ContinueWatchingRow> createState() => _ContinueWatchingRowState();
}

class _ContinueWatchingRowState extends State<ContinueWatchingRow> {
  late final Stream<List<CollectionModel>> _libraryStream = CollectionsRepo(
    isSystem: false,
  ).streamCollections();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CollectionModel>>(
      stream: _libraryStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final entries = _continueEntries(snapshot.data!);
        if (entries.isEmpty) return const SizedBox.shrink();

        final theme = Theme.of(context);
        return LayoutBuilder(
          builder: (context, constraints) {
            const minWidth = 160.0;
            var width = constraints.maxWidth / 5.2;
            if (width < minWidth) width = minWidth;
            final ratio = width / minWidth;
            final cardHeight = width * 9 / 16;
            final titleStyle = theme.textTheme.bodyMedium;
            final baseFontSize = titleStyle?.fontSize ?? 14;
            final fontSize = (baseFontSize * ratio * 0.90)
                .clamp(baseFontSize, double.infinity)
                .toDouble();

            return Padding(
              padding: EdgeInsets.only(top: 10 * ratio, bottom: 8 * ratio),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8 * ratio, 0, 8 * ratio, 8 * ratio),
                    child: Text(
                      'Continue watching',
                      style: titleStyle?.copyWith(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: cardHeight,
                    child: ListView.separated(
                      primary: false,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: entries.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (context, index) => _ContinueCard(
                        entry: entries[index],
                        width: width,
                        height: cardHeight,
                        ratio: ratio,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<_ContinueEntry> _continueEntries(List<CollectionModel> libraryCollections) {
    final candidates =
        <_ContinueEntry>[
          for (final model in widget.discoverCollections.expand((c) => c.series))
            if (model.isSaved) _ContinueEntry(model: model, isSystem: true),
          for (final model in libraryCollections.expand((c) => c.series))
            _ContinueEntry(model: model, isSystem: false),
        ].where((entry) {
          final model = entry.model;
          return model.totalVideos > 0 &&
              model.watchedVideos < model.totalVideos &&
              (model.watchedVideos > 0 || model.inProgressVideos > 0);
        }).toList();

    final byName = <String, _ContinueEntry>{};
    for (final entry in candidates) {
      final key = entry.model.sery.name.trim().toLowerCase();
      final current = byName[key];
      if (current == null ||
          entry.model.sery.updatedAt.isAfter(current.model.sery.updatedAt)) {
        byName[key] = entry;
      }
    }

    return byName.values.toList()
      ..sort((a, b) => b.model.sery.updatedAt.compareTo(a.model.sery.updatedAt));
  }
}

class _ContinueEntry {
  const _ContinueEntry({required this.model, required this.isSystem});

  final SeryModel model;
  final bool isSystem;
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({
    required this.entry,
    required this.width,
    required this.height,
    required this.ratio,
  });

  final _ContinueEntry entry;
  final double width;
  final double height;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = entry.model;
    final progress = (model.watchedVideos / model.totalVideos).clamp(0.0, 1.0).toDouble();
    final visibleProgress = progress == 0 && model.inProgressVideos > 0
        ? 0.025
        : progress;
    final progressLabel = model.watchedVideos > 0
        ? '${model.watchedVideos} of ${model.totalVideos} videos watched'
        : 'Episode in progress';
    final titleFontSize = (theme.textTheme.titleSmall?.fontSize ?? 14) * ratio;
    final detailFontSize = (theme.textTheme.labelSmall?.fontSize ?? 11) * ratio;

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _resume(context),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (model.coverUrl.isNotEmpty)
                Image.network(
                  model.coverUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildFallback(theme, model),
                )
              else
                _buildFallback(theme, model),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xE6000000)],
                    stops: [0.28, 1],
                  ),
                ),
              ),
              Positioned(
                left: 8 * ratio,
                right: 8 * ratio,
                bottom: 8 * ratio,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.sery.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: titleFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      progressLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: detailFontSize,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: LinearProgressIndicator(
                  value: visibleProgress,
                  minHeight: 3 * ratio,
                  backgroundColor: Colors.white.withAlpha(70),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              ),
              Positioned(
                top: 7 * ratio,
                right: 7 * ratio,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(160),
                    borderRadius: BorderRadius.circular(20 * ratio),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7 * ratio,
                      vertical: 4 * ratio,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 14 * ratio,
                        ),
                        SizedBox(width: 2 * ratio),
                        Text(
                          'Resume',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: detailFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallback(ThemeData theme, SeryModel model) {
    return ColoredBox(
      color: theme.colorScheme.primaryContainer,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            model.sery.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall,
          ),
        ),
      ),
    );
  }

  void _resume(BuildContext context) {
    final model = entry.model;
    if (entry.isSystem && model.dataPath != null) {
      final dataPath = model.dataPath!;
      final path = dataPath.endsWith('.binge')
          ? dataPath.substring(0, dataPath.length - '.binge'.length)
          : dataPath;
      context.pushNamed(Pages.series.name, pathParameters: {'slug': '/$path'});
      return;
    }

    context.pushNamed(
      Pages.binge.name,
      queryParameters: BingePage.buildParams(
        type: .seryVideos,
        id: model.sery.id.toString(),
        videoId: model.sery.coverVideoId,
        heroId: model.sery.id.toString(),
        heroImg: model.coverUrl,
      ),
    );
  }
}
