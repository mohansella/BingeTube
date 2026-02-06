import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/common/widget/player/base_player_widget.dart';

class ExternalPlayerWidget extends BasePlayerWidget {
  static final _logger = LogManager.getLogger('ExternalPlayerWidget');

  const ExternalPlayerWidget({
    super.key,
    required super.videoId,
    required super.controller,
    required super.parentScroll,
    required super.childScroll,
    required super.onEvent,
    required super.slivers,
  });

  @override
  ExternalPlayerState createState() => ExternalPlayerState();
}

class ExternalPlayerState extends BasePlayerState {
  bool _isExternallyOpened = false;
  bool _isMarkWatched = false;

  @override
  void restartState() {
    _isExternallyOpened = false;
    _isMarkWatched = false;
    super.restartState();
  }

  @override
  Widget buildPlayPause() {
    return buildIconControl(
      () => _openExternally(),
      Icons.open_in_new_outlined,
      playerWidth / 10,
      'Open Externally',
    );
  }

  @override
  Widget buildSkipNext() {
    if (_isExternallyOpened && !_isMarkWatched) {
      return buildIconControl(
        () {
          setState(() {
            _isMarkWatched = true;
          });
          controller.markActiveVideoWatched();
        },
        Icons.check_outlined,
        playerWidth / 14,
        'Mark Watched',
      );
    }
    return super.buildSkipNext();
  }

  @override
  Widget buildMedia() {
    final imageUrl =
        model?.thumbnails.maxresUrl ??
        model?.thumbnails.standardUrl ??
        model?.thumbnails.highUrl ??
        widget.controller.heroImg;
    return Hero(
      tag: widget.controller.heroId,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Low-res image (always present)
          Image.network(
            widget.controller.heroImg,
            fit: BoxFit.contain,
            frameBuilder: (c, child, frame, wasSyncLoaded) {
              if (frame != null || wasSyncLoaded) {
                return child;
              }
              return _buildCoverFallback(c, widget.videoId);
            },
            errorBuilder: (c, _, _) => _buildCoverFallback(c, widget.videoId),
          ),

          // High-res image fades in ON TOP
          Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => SizedBox(),
            frameBuilder: (context, child, frame, wasSyncLoaded) {
              if (wasSyncLoaded) return child;

              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCoverFallback(BuildContext context, String id) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(id, brightness);
    return Container(color: color, alignment: .center);
  }

  Future<void> _openExternally() async {
    setState(() {
      _isExternallyOpened = true;
    });
    ExternalPlayerWidget._logger.info(
      'opening externally id:${model.video.id} title: ${model.snippet.title}',
    );
    final url = Uri.parse('https://www.youtube.com/watch?v=${model.video.id}');
    controller.markActiveVideoStarted();
    await launchUrl(url, mode: .externalNonBrowserApplication);
  }
}
