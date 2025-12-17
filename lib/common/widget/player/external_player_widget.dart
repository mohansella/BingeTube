import 'package:bingetube/app/theme.dart';
import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalPlayerWidget extends PlayerWidget {
  static final _logger = LogManager.getLogger('ExternalPlayerWidget');

  const ExternalPlayerWidget(super.videoId, {super.key}) : super.internal();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExternalPlayerState();
}

class _ExternalPlayerState extends ConsumerState<ExternalPlayerWidget> {
  final videoDao = VideosDao(Database());
  double _currWidth = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VideoModel>(
      future: videoDao.getVideoModelById(widget.videoId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final model = snapshot.data!;
        return LayoutBuilder(
          builder: (context, constrains) {
            final aspectWidth = constrains.maxHeight * 16.0 / 0.9;
            final aspectHeight = constrains.maxWidth * 9.0 / 16.0;
            double width, height;
            final maxWidth = constrains.maxWidth;
            final maxHeight = constrains.maxHeight;
            if (aspectWidth < maxWidth) {
              width = aspectWidth;
              height = constrains.maxHeight;
            } else {
              width = constrains.maxWidth;
              height = aspectHeight < maxHeight ? aspectHeight : maxHeight;
            }
            _currWidth = width;
            return SizedBox(
              width: width,
              height: height,
              child: _buildStack(model, context),
            );
          },
        );
      },
    );
  }

  Stack _buildStack(VideoModel model, BuildContext context) {
    final imageUrl =
        model.thumbnails.maxresUrl ??
        model.thumbnails.standardUrl ??
        model.thumbnails.highUrl;
    return Stack(
      fit: .expand,
      children: [
        ColoredBox(color: Colors.black),
        Image.network(imageUrl),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.25],
              colors: [Colors.black.withAlpha(200), Colors.transparent],
            ),
          ),
        ),
        _buildControls(model, context),
      ],
    );
  }

  _buildControls(VideoModel model, BuildContext context) {
    final appFontSize = ref.watch(ConfigProviders.appFontSize);
    final theme = Themes.dark(appFontSize);
    return Theme(
      data: theme,
      child: Padding(
        padding: EdgeInsets.all(_currWidth / 40),
        child: Stack(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Tooltip(
                message: 'back',
                child: Icon(Icons.arrow_back, size: _currWidth / 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: _currWidth / 14),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    model.snippet.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: _currWidth / 30,
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  Text(
                    model.snippet.channelTitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: _currWidth / 40,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(140),
                      shape: .circle,
                    ),
                    child: Icon(Icons.skip_previous, size: _currWidth / 14),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _currWidth / 14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(140),
                        shape: .circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          ExternalPlayerWidget._logger.info(
                            'opening externally id:${model.video.id} title: ${model.snippet.title}',
                          );
                          final url = Uri.parse(
                            'https://www.youtube.com/watch?v=${model.video.id}',
                          );
                          launchUrl(url);
                        },
                        child: Icon(Icons.play_arrow, size: _currWidth / 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(140),
                      shape: .circle,
                    ),
                    child: Icon(Icons.skip_next, size: _currWidth / 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
