import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/channel/channel_page.dart';
import 'package:bingetube/pages/configkey/configkey_page.dart';
import 'package:bingetube/pages/edit_binge/edit_binge_page.dart';
import 'package:bingetube/pages/search/search_page.dart';
import 'package:bingetube/pages/series/series_page.dart';
import 'package:bingetube/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'package:bingetube/pages/pages.dart';
import 'package:bingetube/pages/root/root_page.dart';
import 'package:bingetube/pages/discover/discover_page.dart';
import 'package:bingetube/pages/library/library_page.dart';
import 'package:bingetube/pages/profile/profile_page.dart';

import 'package:go_router/go_router.dart';

class Routes {
  final _initNotifier = ValueNotifier<bool>(false);
  final _routeObserver = RouteObserver<ModalRoute<void>>();
  String? _pathAfterSplash;

  late GoRouter _routes;
  Routes() {
    _routes = buildGoRouter();
  }

  static final _instance = Routes();
  static GoRouter getRouterConfig() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return _instance._routes;
  }

  static void popOrHome(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(Pages.discover.name);
    }
  }

  static void updateInitComplete() {
    _instance._initNotifier.value = true;
  }

  static RouteObserver<ModalRoute<void>> getRouteObserver() {
    return _instance._routeObserver;
  }

  GoRouter buildGoRouter() {
    final toReturn = GoRouter(
      observers: [_routeObserver],
      initialLocation: Pages.splash.path,
      refreshListenable: _initNotifier,
      redirect: (context, routeState) {
        String? toReturn;
        if (!_initNotifier.value && routeState.uri.path != Pages.splash.path) {
          _pathAfterSplash = routeState.uri.path;
          toReturn = Pages.splash.path;
        }
        if (_initNotifier.value && routeState.uri.path == Pages.splash.path) {
          toReturn = _pathAfterSplash ?? Pages.discover.path;
        }
        Analytics.logPageView(toReturn ?? routeState.uri.path);
        return toReturn;
      },
      routes: [
        SplashPage.goRoute(),
        RootPage.goRoute(
          routes: [DiscoverPage.goRoute(), LibraryPage.goRoute(), ProfilePage.goRoute()],
        ),
        ConfigKeyPage.goRoute(),
        SearchPage.goRoute(),
        ChannelPage.goRoute(),
        BingePage.goRoute(),
        SeriesPage.goRoute(),
        EditBingePage.goRoute(),
      ],
    );
    return toReturn;
  }
}
