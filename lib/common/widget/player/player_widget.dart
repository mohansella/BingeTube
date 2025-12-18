import 'package:bingetube/common/widget/player/external_player_widget.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class PlayerWidget extends ConsumerStatefulWidget {
  final BingeController controller;
  final Widget child;
  final Function() onBack;

  factory PlayerWidget({
    Key? key,
    required BingeController controller,
    required Function() onBack,
    required Widget child,
  }) {
    return ExternalPlayerWidget(controller: controller, onBack: onBack, child: child);
  }

  const PlayerWidget.internal({
    super.key,
    required this.controller,
    required this.onBack,
    required this.child,
  });
}
