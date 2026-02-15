import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/channel/channel_page.dart';
import 'package:bingetube/pages/configkey/configkey_page.dart';
import 'package:bingetube/pages/edit_binge/edit_binge_page.dart';
import 'package:bingetube/pages/search/search_page.dart';
import 'package:bingetube/pages/splash/splash_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bingetube/pages/pages.dart';
import 'package:bingetube/pages/root/root_page.dart';
import 'package:bingetube/pages/home/home_page.dart';
import 'package:bingetube/pages/myshows/myshows_page.dart';
import 'package:bingetube/pages/settings/settings_page.dart';

import 'package:go_router/go_router.dart';

sealed class Routes {
  static GoRouter getRouterConfig() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return _routes;
  }

  static void popOrHome(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(Pages.myShows.name);
    }
  }

  static void updateInitComplete() {
    _initNotifier.value = true;
  }

  static RouteObserver<ModalRoute<void>> getRouteObserver() {
    return _routeObserver;
  }
}

final _initNotifier = ValueNotifier<bool>(false);

final RouteObserver<ModalRoute<void>> _routeObserver =
    RouteObserver<ModalRoute<void>>();

final GoRouter _routes = GoRouter(
  observers: [
    _routeObserver,
    if (Analytics.isEnabled) ...[
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
  ],
  initialLocation: Pages.splash.path,
  refreshListenable: _initNotifier,
  redirect: (context, routeState) {
    if (!_initNotifier.value && routeState.uri.path != Pages.splash.path) {
      return Pages.splash.path;
    }
    if (_initNotifier.value && routeState.uri.path == Pages.splash.path) {
      return Pages.myShows.path;
    }
    return null;
  },
  routes: [
    CustomGoRoute(
      page: Pages.splash,
      customBuilder: (context, state) => const SplashPage(),
    ),
    ShellRoute(
      routes: [
        CustomGoRoute(
          page: Pages.home,
          transistionType: .none,
          customBuilder: (context, state) => const HomePage(),
        ),
        CustomGoRoute(
          page: Pages.myShows,
          transistionType: .none,
          customBuilder: (context, state) => const MyShowsPage(),
        ),
        CustomGoRoute(
          page: Pages.settings,
          transistionType: .none,
          customBuilder: (context, state) => const SettingsPage(),
        ),
      ],
      builder: (context, state, child) => RootPage(body: child),
    ),
    CustomGoRoute(
      page: Pages.keyConfig,
      customBuilder: (context, state) => const ConfigKeyPage(),
    ),
    CustomGoRoute(
      page: Pages.search,
      customBuilder: (context, state) => const SearchPage(),
    ),
    CustomGoRoute(
      page: Pages.channel,
      customBuilder: (context, state) => ChannelPage(state.uri.queryParameters),
    ),
    CustomGoRoute(
      page: Pages.binge,
      customBuilder: (context, state) => BingePage(state.uri.queryParameters),
    ),
    CustomGoRoute(
      page: Pages.editBinge,
      customBuilder: (context, state) =>
          EditBingePage(state.uri.queryParameters),
    ),
  ],
);

enum PageTransistionType { predefined, none, fade }

class CustomGoRoute extends GoRoute {
  final GoRouterWidgetBuilder customBuilder;
  final Pages page;
  final PageTransistionType transistionType;

  CustomGoRoute({
    required this.page,
    required this.customBuilder,
    this.transistionType = .predefined,
  }) : super(
         name: page.name,
         path: page.path,
         builder: customBuilder,
         pageBuilder: transistionType == .predefined
             ? null
             : (c, s) => buildTransistion(transistionType, customBuilder, c, s),
       );

  static Page<dynamic> buildTransistion(
    PageTransistionType type,
    GoRouterWidgetBuilder customBuilder,
    BuildContext context,
    GoRouterState state,
  ) {
    if (type == .fade) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: customBuilder(context, state),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    }
    return NoTransitionPage(child: customBuilder(context, state));
  }
}
