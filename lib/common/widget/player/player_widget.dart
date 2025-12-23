import 'package:bingetube/common/widget/player/external_player_widget.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum PlayerEventType { onBack, onPrev, onNext, onPause, onPlay }

abstract class PlayerWidget extends ConsumerStatefulWidget {
  final BingeController controller;
  final ScrollController scrollController;
  final List<Widget> slivers;
  final Function(PlayerEventType) onEvent;

  factory PlayerWidget({
    Key? key,
    required BingeController controller,
    required Function(PlayerEventType) onEvent,
    required List<Widget> slivers,
    required ScrollController scrollController,
  }) {
    return ExternalPlayerWidget(
      key: key,
      controller: controller,
      scrollController: scrollController,
      onEvent: onEvent,
      slivers: slivers,
    );
  }

  const PlayerWidget.internal({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.onEvent,
    required this.slivers,
  });
}
