import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InternalPlayerWidget extends PlayerWidget {
  const InternalPlayerWidget({
    super.key,
    required super.videoId,
    required super.controller,
    required super.parentScroll,
    required super.childScroll,
    required super.onEvent,
    required super.slivers,
  }) : super.internal();

  @override
  ConsumerState<InternalPlayerWidget> createState() =>
      _InternalPlayerWidgetState();
}

class _InternalPlayerWidgetState extends ConsumerState<InternalPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('internal player: ${widget.videoId}');
  }
}
