import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/constants/assets.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initAll();
  }

  void initAll() async {
    final stopwatch = Stopwatch()..start();
    await ConfigStore.init();
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
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.4, // 40% of screen width
          child: Lottie.asset(Assets.bingePanda.path),
        ),
      ),
    );
  }
}
