import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/db/models/sery_model.dart';
import 'package:flutter/material.dart';

class SeryPreviewText {
  static String description(SeryModel model) {
    final rawDescription = model.sery.description.trim();
    final description = rawDescription.replaceAll(RegExp(r'\s+'), ' ');
    if (description.isNotEmpty) {
      return description;
    }

    final count = videoCount(model.totalVideos);
    return 'A curated $count binge ready to watch.';
  }

  static String videoCount(int totalVideos) {
    return totalVideos == 1 ? '1 video' : '$totalVideos videos';
  }
}

class SeryLoadingPreviewCard extends StatelessWidget {
  final SeryModel model;
  final int descriptionLines;

  const SeryLoadingPreviewCard({
    super.key,
    required this.model,
    this.descriptionLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = SeryPreviewText.description(model);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(context),
            _buildGradient(),
            _buildVideoCount(),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildChannelIcon(),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          model.sery.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: descriptionLines,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withAlpha(225),
                      height: 1.18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Image.network(
      model.coverUrl,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null || wasSynchronouslyLoaded) {
          return child;
        }
        return _buildFallback(context);
      },
      errorBuilder: (context, _, _) => _buildFallback(context),
    );
  }

  Widget _buildFallback(BuildContext context) {
    final theme = Theme.of(context);
    final color = Themes.colorFromId(
      model.sery.coverVideoId,
      theme.brightness,
      sat: 0.42,
      light: 0.62,
      dark: 0.22,
    );
    return Container(
      color: color,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Text(
        model.sery.name,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withAlpha(225),
            Colors.black.withAlpha(95),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Positioned _buildVideoCount() {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(180),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_arrow, size: 13, color: Colors.white),
            const SizedBox(width: 3),
            Text(
              SeryPreviewText.videoCount(model.totalVideos),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: ClipOval(
        child: Image.network(
          model.iconUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(color: Colors.white24),
        ),
      ),
    );
  }
}
