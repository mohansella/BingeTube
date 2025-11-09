import 'package:bingetube/pages/Pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatelessWidget {
  const RootPage({required this.body, super.key});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: Pages.home.text),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: Pages.myshows.text),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Pages.settings.text,
          ),
        ],
        onTap: (index) {
          List<Pages> navPages = [Pages.home, Pages.myshows, Pages.settings];
          context.go(navPages[index].path);
        },
      ),
    );
  }
}
