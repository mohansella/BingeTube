import 'package:bingetube/common/widget/player/player/player.dart';
import 'package:flutter/material.dart';

import 'package:bingetube/app/routes.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/common/widget/player/base_player_widget.dart';

class InternalPlayerWidget extends BasePlayerWidget {
  static final _logger = LogManager.getLogger('InternalPlayerWidget');

  const InternalPlayerWidget({
    super.key,
    required super.videoId,
    required super.controller,
    required super.parentScroll,
    required super.childScroll,
    required super.onEvent,
    required super.slivers,
    required super.isCollapsed,
  });

  @override
  BasePlayerState createState() => _InternalPlayerState();
}

class _InternalPlayerState extends BasePlayerState implements PlayerListener {
  late Player player;

  _InternalPlayerState() {
    player = Player.create(this);
    InternalPlayerWidget._logger.info('player name: ${player.playerName}');
  }

  @override
  void didUpdateWidget(covariant InternalPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoId != widget.videoId) {
      player.loadVideo(widget.videoId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: super.build(context));
  }

  @override
  Widget buildMedia() {
    return player.build(widget.videoId);
  }

  @override
  Widget buildControls(BuildContext context) {
    return SizedBox();
  }

  AppBar? _buildAppBar() {
    if (!widget.isCollapsed) {
      return null;
    }
    final iconSize = 28.0;
    final style = TextStyle(fontSize: 14);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          buildIconControl(
            () => Routes.popOrHome(context),
            Icons.arrow_back,
            iconSize,
            'Back',
            colorDecoration: false,
          ),
          buildIconControl(
            controller.isPrevVideoExists ? () => widget.onEvent(.onPrev) : null,
            Icons.skip_previous,
            iconSize,
            'Skip Previous',
            colorDecoration: false,
            text: 'Previous Ep.',
            textStyle: style,
          ),
          buildIconControl(
            controller.isNextVideoExists ? () => widget.onEvent(.onNext) : null,
            Icons.skip_next,
            iconSize,
            'Skip Next',
            colorDecoration: false,
            text: 'Next Ep.',
            textStyle: style,
          ),
          buildIconControl(
            () => widget.onEvent(.onListToggle),
            Icons.video_library_outlined,
            iconSize - 5,
            'Episodes',
            text: 'All Ep.',
            colorDecoration: false,
            textStyle: style,
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPlayPause() {
    return SizedBox();
  }

  @override
  void onPlayerError(String payload) {
    InternalPlayerWidget._logger.warning(
      'unexpected error in player: $payload',
    );
  }

  @override
  void onPlayerProgress(String payload) {
    final splits = payload.split(',');

    final current = double.parse(splits[0]);
    final duration = double.parse(splits[1]);
    final progress = splits[2];
    InternalPlayerWidget._logger.finer(
      'progress:$progress current:$current duration:$duration',
    );

    if (duration - current < 0) {
      if (controller.isNextVideoExists) {
        widget.onEvent(.onNext);
      }
    }
  }

  @override
  void onPlayerQualityChange(String payload) {}

  @override
  void onPlayerRateChange(String payload) {}

  @override
  void onPlayerReady() {
    player.startProgressTracking();
  }

  @override
  void onPlayerStateChange(String payload) {}
}
