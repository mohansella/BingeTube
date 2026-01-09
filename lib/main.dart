import 'package:bingetube/app/app.dart';
import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigStore.init();
  await Analytics.init();
  runApp(ProviderScope(child: const App()));
}
