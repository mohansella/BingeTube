import 'package:bingetube/common/widget/binge/list_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ListScreenWidget(isSystem: true));
  }
}
