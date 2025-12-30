import 'package:bingetube/app/routes.dart';
import 'package:bingetube/core/constants/assets.dart';
import 'package:bingetube/core/init.dart';
import 'package:flutter/material.dart';
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
    initAndGo();
  }

  void initAndGo() async {
    final stopwatch = Stopwatch()..start();
    await CoreInit.initAll();
    stopwatch.stop();
    final delta = Duration(seconds: 1) - stopwatch.elapsed;
    if (delta > Duration.zero) {
      await Future.delayed(delta);
    }
    Routes.updateInitComplete();
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
