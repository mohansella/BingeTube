import 'package:bingetube/common/widget/binge/list_screen.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ListScreenWidget(isSystem: true));
  }

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .discover,
      transistionType: .none,
      customBuilder: (_, _) => DiscoverPage(),
    );
  }
}
