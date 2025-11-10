import 'package:bingetube/core/utils/SecureStorage.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  @override
  void initState() {
    super.initState();
    initAll();
  }

  void initAll() async {
    final stopwatch = Stopwatch()..start();
    await SecureStorage.init();
    stopwatch.stop();
    final delta = Duration(seconds: 1) - stopwatch.elapsed;
    if (delta > Duration.zero) {
      await Future.delayed(delta);
    }
    if (mounted) {
      context.go(Pages.home.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
