import 'package:bingetube/common/widget/binge/choose_collection.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/core/db/repo/collections_repo.dart';
import 'package:bingetube/core/db/repo/series_repo.dart';
import 'package:bingetube/core/lang/mutable.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeaturedSeriesHero extends StatefulWidget {
  const FeaturedSeriesHero({required this.model, required this.collection, super.key});

  final SeryModel model;
  final CollectionModel collection;

  @override
  State<FeaturedSeriesHero> createState() => _FeaturedSeriesHeroState();
}

class _FeaturedSeriesHeroState extends State<FeaturedSeriesHero> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 520;
        final textScale = (constraints.maxWidth / 520).clamp(0.82, 1.3).toDouble();
        final height = isCompact
            ? (constraints.maxWidth * 0.62).clamp(220.0, 360.0).toDouble()
            : (constraints.maxWidth * 0.34).clamp(240.0, 320.0).toDouble();
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildCover(context),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.transparent,
                          Color(0xAA000000),
                          Color(0xE6000000),
                        ],
                        stops: [0.0, 0.42, 1.0],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.68),
                      child: Padding(
                        padding: EdgeInsets.all(isCompact ? 16 : 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FEATURED TODAY',
                              style:
                                  _scaledTextStyle(
                                    theme.textTheme.labelMedium,
                                    textScale,
                                  )?.copyWith(
                                    color: Colors.white.withAlpha(220),
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.model.sery.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  _scaledTextStyle(
                                    theme.textTheme.headlineSmall,
                                    textScale,
                                  )?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    height: 1.05,
                                  ),
                            ),
                            if (!isCompact &&
                                widget.model.sery.description.trim().isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                widget.model.sery.description.trim(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    _scaledTextStyle(
                                      theme.textTheme.bodySmall,
                                      textScale,
                                    )?.copyWith(
                                      color: Colors.white.withAlpha(225),
                                      height: 1.3,
                                    ),
                              ),
                            ],
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: [
                                FilledButton.icon(
                                  onPressed: _openFeatured,
                                  icon: const Icon(Icons.play_arrow_rounded),
                                  label: const Text('Play series'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    textStyle: _scaledTextStyle(
                                      theme.textTheme.labelLarge,
                                      textScale,
                                    ),
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: _isSaving ? null : _saveToLibrary,
                                  icon: _isSaving
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(Icons.add),
                                  label: Text(_isSaving ? 'Saving' : 'Add to Library'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(color: Colors.white.withAlpha(180)),
                                    textStyle: _scaledTextStyle(
                                      theme.textTheme.labelLarge,
                                      textScale,
                                    ),
                                  ),
                                ),
                              ],
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
      },
    );
  }

  TextStyle? _scaledTextStyle(TextStyle? style, double scale) {
    final fontSize = style?.fontSize;
    if (style == null || fontSize == null) return style;
    return style.copyWith(fontSize: fontSize * scale);
  }

  Widget _buildCover(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.model.coverUrl.isEmpty) {
      return ColoredBox(color: theme.colorScheme.surfaceContainerHighest);
    }
    return Image.network(
      widget.model.coverUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          ColoredBox(color: theme.colorScheme.surfaceContainerHighest),
    );
  }

  void _openFeatured() {
    final dataPath = widget.model.dataPath;
    if (dataPath == null) return;
    final path = dataPath.endsWith('.binge')
        ? dataPath.substring(0, dataPath.length - '.binge'.length)
        : dataPath;
    context.pushNamed(Pages.series.name, pathParameters: {'slug': '/$path'});
  }

  Future<void> _saveToLibrary() async {
    final destination = await ChooseCollectionWidget.showChooseCollection(
      context,
      title: 'Add to a collection',
    );
    if (destination == null || !mounted) return;

    setState(() => _isSaving = true);
    try {
      final existingCollections = await CollectionsRepo(
        isSystem: false,
      ).streamCollections().first;
      final alreadyAdded = existingCollections
          .expand((collection) => collection.series)
          .any(
            (series) =>
                series.dataPath == widget.model.dataPath ||
                series.sery.name == widget.model.sery.name,
          );
      if (alreadyAdded) {
        _showMessage('This series is already in your library.');
        return;
      }

      var source = widget.model.sery;
      if (!widget.model.isSaved) {
        final downloaded = await SeriesRepo(
          isSystem: true,
        ).downloadSery(Mutable(false), widget.collection, widget.model);
        if (downloaded == null) return;
        source = downloaded;
      }
      await BingeDao(Database()).duplicateSery(source.id, destination.id);
      _showMessage('Added ${widget.model.sery.name} to ${destination.name}.');
    } catch (error) {
      _showMessage('Could not add this series: $error');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
