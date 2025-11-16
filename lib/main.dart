import 'package:bingetube/app/app.dart';
import 'package:bingetube/core/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureStorage.init();
  runApp(ProviderScope(child: const App()));
}
