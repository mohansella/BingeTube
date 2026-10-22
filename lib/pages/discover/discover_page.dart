import 'package:bingetube/common/widget/binge/list_screen.dart';
import 'package:bingetube/core/db/models/collection_model.dart';
import 'package:bingetube/pages/discover/featured_series_hero.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListScreenWidget(isSystem: true, headerBuilder: _buildFeaturedHero);
  }

  Widget _buildFeaturedHero(List<CollectionModel> collections) {
    final featured =
        collections
            .expand((collection) => collection.series)
            .where((series) => series.featuredRank != null)
            .toList()
          ..sort((a, b) => a.featuredRank!.compareTo(b.featuredRank!));
    if (featured.isEmpty) return const SizedBox.shrink();

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
