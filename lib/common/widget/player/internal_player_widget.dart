import 'package:bingetube/common/widget/player/player/player.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
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

class _InternalPlayerState extends BasePlayerState
    with RouteAware
    implements PlayerListener {
  late Player player;

  _InternalPlayerState() {
    player = Player.create(this);
    InternalPlayerWidget._logger.info('player name: ${player.playerName}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Routes.getRouteObserver().subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    Routes.getRouteObserver().unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    player.pause();
  }

  @override
  void didPopNext() {
    player.play();
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

  String _progId = '';
  double _progPos = 0;
  @override
  void onPlayerProgress(String payload) async {
    final splits = payload.split(',');

    final pos = double.parse(splits[0]);
    final duration = double.parse(splits[1]);
    final progress = splits[2];
    InternalPlayerWidget._logger.finer(
      'pos:$pos duration:$duration progress:$progress',
    );
    final id = model!.video.id;
    final dao = VideosDao(Database());

    bool isFinished = false;
    if (duration - pos < 0) {
      isFinished = true;
      if (controller.isNextVideoExists) {
        widget.onEvent(.onNext);
      }
    }

    if (!isFinished && _progId == id && (_progPos - pos).abs() < 10) {
      return;
    } else {
      _progId = id;
      _progPos = pos;
    }
    await dao.upsertVideoProgress(id, isFinished, pos: pos);
  }

  @override
  void onPlayerQualityChange(String payload) {}

  @override
  void onPlayerRateChange(String payload) {}

  @override
  void onPlayerReady() {
    player.startProgressTracking();
    final pos = model!.progressData.watchPosition;
    player.seekTo(pos);
  }

  @override
  void onPlayerStateChange(String payload) {}
}
