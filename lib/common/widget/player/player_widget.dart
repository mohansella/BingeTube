import 'package:bingetube/common/widget/player/external_player_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class PlayerWidget extends ConsumerStatefulWidget {
  final String videoId;

  factory PlayerWidget(String videoId, {Key? key}) {
    return ExternalPlayerWidget(videoId, key: key);
  }

  const PlayerWidget.internal(this.videoId, {super.key});
}

