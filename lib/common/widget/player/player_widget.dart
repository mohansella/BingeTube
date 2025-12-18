import 'package:bingetube/common/widget/player/external_player_widget.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class PlayerWidget extends ConsumerStatefulWidget {
  final BingeController controller;
  final Function() onBack;

  factory PlayerWidget(
    BingeController controller,
    Function() onBack, {
    Key? key,
  }) {
    return ExternalPlayerWidget(controller, onBack, key: key);
  }

  const PlayerWidget.internal(this.controller, this.onBack, {super.key});
}
