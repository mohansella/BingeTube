import 'package:bingetube/common/widget/binge/list_screen.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ListScreenWidget(isSystem: false));
  }

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .library,
      transistionType: .none,
      customBuilder: (_, _) => LibraryPage(),
    );
  }
}
