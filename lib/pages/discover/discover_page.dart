import 'package:bingetube/common/widget/binge/list_screen.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ListScreenWidget(isSystem: true));
  }
}
