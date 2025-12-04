import 'package:bingetube/pages/binge_results/binge_results_page.dart';
import 'package:bingetube/pages/configkey/configkey_page.dart';
import 'package:bingetube/pages/search/search_page.dart';
import 'package:bingetube/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'package:bingetube/pages/pages.dart';
import 'package:bingetube/pages/root/root_page.dart';
import 'package:bingetube/pages/home/home_page.dart';
import 'package:bingetube/pages/myshows/myshows_page.dart';
import 'package:bingetube/pages/settings/settings_page.dart';

import 'package:go_router/go_router.dart';

sealed class Routes {
  static GoRouter getRouterConfig() {
    return _routes;
  }
}

final GoRouter _routes = GoRouter(
  initialLocation: Pages.splash.path,
  routes: [
    CustomGoRoute(
      path: Pages.splash.path,
      customBuilder: (context, state) => const SplashPage(),
    ),
    ShellRoute(
      routes: [
        CustomGoRoute(
          path: Pages.home.path,
          customBuilder: (context, state) => const HomePage(),
        ),
        CustomGoRoute(
          path: Pages.myShows.path,
          customBuilder: (context, state) => const MyShowsPage(),
        ),
        CustomGoRoute(
          path: Pages.settings.path,
          customBuilder: (context, state) => const SettingsPage(),
        ),
      ],
      builder: (context, state, child) => RootPage(body: child),
    ),
    CustomGoRoute(
      path: Pages.keyConfig.path,
      customBuilder: (context, state) => const ConfigKeyPage(),
    ),
    CustomGoRoute(
      path: Pages.search.path,
      customBuilder: (context, state) => const SearchPage(),
    ),
    CustomGoRoute(
      path: Pages.bingeResults.path,
      customBuilder: (context, state) => const BingeResultsPage(),
    ),
  ],
);

class CustomGoRoute extends GoRoute {
  final GoRouterWidgetBuilder customBuilder;

  CustomGoRoute({required super.path, required this.customBuilder})
    : super(
        builder: customBuilder,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 250),
          child: customBuilder(context, state),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
}
