import 'package:bingetube/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

MaterialApp getRoutedApp() {
  return MaterialApp.router(routerConfig: routes);
}

final GoRouter routes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state)=>const HomePage())
]);

