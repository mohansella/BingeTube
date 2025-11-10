import 'package:bingetube/app/app.dart';
import 'package:bingetube/core/utils/SecureStorage.dart';
import 'package:flutter/material.dart';

void main() async {
  await SecureStorage.init();
  runApp(const App());
}
