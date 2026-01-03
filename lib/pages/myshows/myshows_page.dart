import 'package:bingetube/common/widget/binge/list_screen.dart';
import 'package:flutter/material.dart';

class MyShowsPage extends StatelessWidget {
  const MyShowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ListScreenWidget(isSystem: false));
  }
}
