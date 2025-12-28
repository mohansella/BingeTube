import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditBingePage extends ConsumerStatefulWidget {
  final Map<String, String> params;

  const EditBingePage(this.params, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditBingePageState();
}

class _EditBingePageState extends ConsumerState<EditBingePage> {
  late BingeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Text('from edit binge page'));
  }
}
