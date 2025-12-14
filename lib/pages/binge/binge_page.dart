import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BingePage extends ConsumerStatefulWidget {
  const BingePage(Map<String, String> params, {super.key});

  @override
  ConsumerState createState() => _BingePageState();
}

class _BingePageState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Binge Video')));
  }
}
