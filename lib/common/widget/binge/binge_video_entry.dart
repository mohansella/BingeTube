import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:flutter/material.dart';

class BingeVideoEntry extends StatelessWidget {
  final VideoModel video;
  final int position;
  final bool isActive;
  final bool isSelected;
  final bool showSelection;
  final bool isDragEnabled;
  final int? dragIndex;
  final VoidCallback? onTap;
  final VoidCallback? onWatchedPressed;

  const BingeVideoEntry({
    super.key,
    required this.video,
    required this.position,
    this.isActive = false,
    this.isSelected = false,
    this.showSelection = false,
    this.isDragEnabled = false,
    this.dragIndex,
    this.onTap,
    this.onWatchedPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = isActive
        ? theme.colorScheme.primary
        : isSelected
        ? theme.colorScheme.secondary
        : theme.colorScheme.outlineVariant;
    final background = isActive
        ? theme.colorScheme.primaryContainer.withAlpha(125)
        : isSelected
        ? theme.colorScheme.secondaryContainer.withAlpha(115)
        : theme.colorScheme.surface;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor, width: isActive || isSelected ? 1.2 : 1),
      ),
      child: InkWell(
        mouseCursor: onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompactList = constraints.maxWidth < 460;
            final thumbnail = _buildThumbnail(context, isCompactList: isCompactList);
            final details = _buildDetails(context, showDescription: !isCompactList);

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                thumbnail,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      isCompactList ? 10 : 14,
                      isCompactList ? 8 : 12,
                      8,
                      isCompactList ? 8 : 12,
                    ),
                    child: details,
                  ),
                ),
                if (onWatchedPressed != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: _buildWatchedButton(context),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context, {required bool isCompactList}) {
    final content = AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildVideoCardImage(context),
          Positioned.fill(child: DecoratedBox(decoration: _thumbnailScrim())),
          Positioned(left: 6, top: 6, child: _buildPositionBadge(context)),
          if (showSelection)
            Positioned(right: 6, top: 6, child: _buildSelectionBadge(context)),
          if (isActive) Center(child: _buildActiveBadge(context)),
          if (isDragEnabled) Center(child: _buildDragBadge(context)),
          Positioned(right: 6, bottom: 8, child: _buildDurationBadge(context)),
          Positioned(left: 0, right: 0, bottom: 0, child: _buildProgress(context)),
        ],
      ),
    );

    final width = isCompactList ? 118.0 : 170.0;
    final wrappedContent = SizedBox(width: width, child: content);

    if (isDragEnabled && dragIndex != null) {
      return ReorderableDragStartListener(
        index: dragIndex!,
        enabled: isDragEnabled,
        child: MouseRegion(cursor: SystemMouseCursors.grab, child: wrappedContent),
      );
    }

    return wrappedContent;
  }

  BoxDecoration _thumbnailScrim() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withAlpha(95),
          Colors.black.withAlpha(0),
          Colors.black.withAlpha(115),
        ],
        stops: const [0, 0.52, 1],
      ),
    );
  }

  Widget _buildDetails(BuildContext context, {required bool showDescription}) {
    final theme = Theme.of(context);
    final description = video.snippet.description.trim();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                video.formattedTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: _buildMetaPills(context),
        ),
        if (showDescription && description.isNotEmpty) ...[
          const SizedBox(height: 7),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildMetaPills(BuildContext context) {
    return [
      _buildMetaPill(
        context,
        Icons.person_outline,
        video.snippet.channelTitle,
        isPrimary: true,
      ),
      _buildMetaPill(context, Icons.schedule_outlined, _progressLabel()),
    ];
  }

  Widget _buildMetaPill(
    BuildContext context,
    IconData icon,
    String text, {
    bool isPrimary = false,
  }) {
    final theme = Theme.of(context);
    final color = isPrimary
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWatchedButton(BuildContext context) {
    final watched = video.progressData.isFinished;
    return IconButton(
      tooltip: watched ? 'Mark Unwatched' : 'Mark Watched',
      visualDensity: VisualDensity.compact,
      icon: Icon(watched ? Icons.visibility_off_outlined : Icons.visibility_outlined),
      onPressed: onWatchedPressed,
    );
  }

  Widget _buildVideoCardImage(BuildContext context) {
    return Image.network(
      video.thumbnails.mediumUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      frameBuilder: (c, child, frame, wasSyncLoaded) {
        if (frame != null || wasSyncLoaded) {
          return child;
        }
        return _buildCoverFallback(c, video.video.id);
      },
      errorBuilder: (c, _, _) => _buildCoverFallback(c, video.video.id),
    );
  }

  Widget _buildCoverFallback(BuildContext context, String id) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(id, brightness);
    return ColoredBox(
      color: color,
      child: Center(
        child: Icon(
          Icons.smart_display_outlined,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildPositionBadge(BuildContext context) {
    final theme = Theme.of(context);
    final label = position.toString().padLeft(2, '0');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(170),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildSelectionBadge(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.surface.withAlpha(220),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Icon(
        isSelected ? Icons.check : Icons.check_box_outline_blank,
        size: 18,
        color: isSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildActiveBadge(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(225),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow_rounded, size: 18, color: theme.colorScheme.onPrimary),
          const SizedBox(width: 4),
          Text(
            'Playing',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragBadge(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.drag_handle_rounded, color: Colors.white),
    );
  }

  Widget _buildDurationBadge(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(190),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        video.formatDuration(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildProgress(BuildContext context) {
    final theme = Theme.of(context);
    return LinearProgressIndicator(
      value: _safeProgressPercent(),
      minHeight: 4,
      backgroundColor: Colors.white.withAlpha(55),
      color: video.progressData.isFinished
          ? theme.colorScheme.tertiary
          : theme.colorScheme.primary,
    );
  }

  String _progressLabel() {
    if (video.progressData.isFinished) {
      return 'Watched';
    }
    final percent = (_safeProgressPercent() * 100).round();
    if (percent <= 0) {
      return 'Not started';
    }
    return '$percent% watched';
  }

  double _safeProgressPercent() {
    final value = video.progressPercent;
    if (value.isNaN || value.isInfinite) {
      return video.progressData.isFinished ? 1.0 : 0.0;
    }
    return value.clamp(0.0, 1.0).toDouble();
  }
}
