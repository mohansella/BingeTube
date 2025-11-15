import 'package:bingetube/pages/Pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatelessWidget {
  const RootPage({required this.body, super.key});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BingeTube'),
        leading: Padding(padding: EdgeInsets.only(left: 8.0),
        child: Image.asset('assets/images/logo.png')),
        leadingWidth: 45,
        titleSpacing: 10,
        actions: [
          IconButton(
            onPressed: () => context.push(Pages.keyConfig.path),
            icon: Icon(Icons.key),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () => context.push(Pages.search.path),
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Pages.home.text,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: Pages.myShows.text,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Pages.settings.text,
          ),
        ],
        onTap: (index) {
          List<Pages> navPages = [Pages.home, Pages.myShows, Pages.settings];
          context.push(navPages[index].path);
        },
      ),
    );
  }
}
