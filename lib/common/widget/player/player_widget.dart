import 'package:bingetube/common/widget/player/external_player_widget.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class PlayerWidget extends ConsumerStatefulWidget {
  final BingeController controller;

  factory PlayerWidget(
    BingeController controller, {
    Key? key
  }) {
    return ExternalPlayerWidget(
      controller,
      key: key
    );
  }

  const PlayerWidget.internal(
    this.controller, {
    super.key,
  });
}
