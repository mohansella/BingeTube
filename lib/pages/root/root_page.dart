import 'package:bingetube/core/constants/assets.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatefulWidget {
  const RootPage({required this.body, super.key});
  final Widget body;

  @override
  State<StatefulWidget> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  int _bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BingeTube'),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Image.asset(Assets.logoPng.path),
        ),
        leadingWidth: 45,
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(Pages.keyConfig.name),
            icon: Icon(Icons.key),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () => context.pushNamed(Pages.search.name),
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavBarIndex,
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
          context.goNamed(navPages[index].name);
          setState(() {
            _bottomNavBarIndex = index;
          });
        },
      ),
    );
  }
}
