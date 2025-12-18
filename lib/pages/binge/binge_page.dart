import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BingePage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('BingePage');

  final Map<String, String> params;

  const BingePage(this.params, {super.key});

  @override
  ConsumerState createState() => _BingePageState();

  static String buildPath(BingeControllerType type, String id) {
    final buffer = StringBuffer('${Pages.binge.path}?type=${type.name}&id=$id');
    final toReturn = buffer.toString();
    _logger.info('built path: $toReturn');
    return toReturn;
  }
}

class _BingePageState extends ConsumerState<BingePage> {
  late BingeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerWidget(
        controller: _controller,
        onBack: () => Navigator.pop(context),
        child: Text('Hi'),
      ),
    );
  }
}
