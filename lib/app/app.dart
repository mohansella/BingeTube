import 'package:bingetube/app/routes.dart';
import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final themeMode = ref.watch(ConfigProviders.theme);
  final appFontSize = ref.watch(ConfigProviders.appFontSize);
  return MaterialApp.router(
    themeMode: themeMode,
    theme: Themes.light(appFontSize),
    darkTheme: Themes.dark(appFontSize),
    routerConfig: Routes.getRouterConfig(),
    debugShowCheckedModeBanner: true,
  );
  }
}
