import 'package:bingetube/common/contact_support.dart';
import 'package:bingetube/common/widget/binge/list_screen.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:bingetube/pages/discover/continue_watching_row.dart';
import 'package:bingetube/pages/discover/featured_series_hero.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListScreenWidget(
      isSystem: true,
      headerBuilder: _buildFeaturedHero,
      footerBuilder: _buildDiscordInvite,
    );
  }

  Widget _buildDiscordInvite(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final theme = Theme.of(context);
          final colors = theme.colorScheme;
          final scale = (constraints.maxWidth / 5.2 / 160).clamp(1.0, 1.8).toDouble();
          final bodySize = theme.textTheme.bodyMedium?.fontSize ?? 14;
          final smallSize = theme.textTheme.bodySmall?.fontSize ?? 12;
          final titleStyle = theme.textTheme.bodyMedium?.copyWith(
            fontSize: (bodySize * scale * 0.9).clamp(bodySize, bodySize * 1.4).toDouble(),
            fontWeight: FontWeight.w600,
          );
          final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
            fontSize: (smallSize * scale * 0.9)
                .clamp(smallSize, smallSize * 1.4)
                .toDouble(),
            color: colors.onSurfaceVariant,
          );

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(height: 1),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => ContactSupport.openDiscord(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.discord, color: colors.primary, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Join the BingeTube community', style: titleStyle),
                            Text('Chat with us on Discord', style: subtitleStyle),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.open_in_new_rounded,
                        color: colors.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeaturedHero(List<CollectionModel> collections) {
    final featured =
        collections
            .expand((collection) => collection.series)
            .where((series) => series.featuredRank != null)
            .toList()
          ..sort((a, b) => a.featuredRank!.compareTo(b.featuredRank!));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (featured.isNotEmpty) ...[_buildFeaturedSeries(collections, featured)],
        ContinueWatchingRow(
          key: const ValueKey('continue-watching'),
          discoverCollections: collections,
        ),
      ],
    );
  }

  Widget _buildFeaturedSeries(
    List<CollectionModel> collections,
    List<SeryModel> featured,
  ) {
    final dayIndex = DateTime.now().difference(DateTime(2025)).inDays;
    final model = featured[dayIndex % featured.length];
    final collection = collections.firstWhere((item) => item.series.contains(model));
    return FeaturedSeriesHero(model: model, collection: collection);
  }

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .discover,
      transistionType: .none,
      customBuilder: (_, _) => DiscoverPage(),
    );
  }
}
