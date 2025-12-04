import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BingeResultsPage extends ConsumerStatefulWidget {
  const BingeResultsPage({super.key});

  @override
  ConsumerState createState() => _BingeResultsPageState();
}

class _BingeResultsPageState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Binge Video')));
  }
}
