import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bingetube/core/config/player_type.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/common/widget/player/external_player_widget.dart';
import 'package:bingetube/common/widget/player/internal_player_widget.dart';

enum PlayerEventType {
  onBack,
  onPrev,
  onNext,
  onPause,
  onPlay,
  onHeight,
  onScrollEnd,
  onListToggle,
}

abstract class PlayerWidget extends ConsumerStatefulWidget {
  final String videoId;
  final BingeController controller;
  final ScrollController parentScroll;
  final ScrollController childScroll;
  final List<Widget> slivers;
  final Function(PlayerEventType, {Object? data}) onEvent;

  factory PlayerWidget({
    Key? key,
    required PlayerType playerType,
    required String videoId,
    required BingeController controller,
    required Function(PlayerEventType, {Object? data}) onEvent,
    required List<Widget> slivers,
    required ScrollController parentScroll,
    required ScrollController childScroll,
  }) {
    if (playerType == .internal) {
      return InternalPlayerWidget(
        videoId: videoId,
        controller: controller,
        parentScroll: parentScroll,
        childScroll: childScroll,
        onEvent: onEvent,
        slivers: slivers,
      );
    }
    return ExternalPlayerWidget(
      key: key,
      videoId: videoId,
      controller: controller,
      parentScroll: parentScroll,
      childScroll: childScroll,
      onEvent: onEvent,
      slivers: slivers,
    );
  }

  const PlayerWidget.internal({
    super.key,
    required this.videoId,
    required this.controller,
    required this.parentScroll,
    required this.childScroll,
    required this.onEvent,
    required this.slivers,
  });
}
