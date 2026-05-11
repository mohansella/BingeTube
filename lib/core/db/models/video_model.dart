import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/channel_model.dart';

class VideoModel {
  final Video video;
  final VideoSnippet snippet;
  final VideoThumbnail thumbnails;
  final VideoContentDetail contentDetails;
  final VideoStatuse status;
  final VideoStatistic statistics;
  final VideoProgressData progressData;
  final ChannelModel channel;
  late String formattedTitle;

  VideoModel({
    required this.video,
    required this.snippet,
    required this.thumbnails,
    required this.contentDetails,
    required this.status,
    required this.statistics,
    required this.progressData,
    required this.channel,
  }) {
    formattedTitle = formatTitle();
  }

  double get progressPercent {
    if (progressData.isFinished) {
      return 1;
    }
    return progressData.watchPosition / duration;
  }

  String formatTitle() {
    final title = snippet.title;
    String? parse(String pattern, String prefix, int pad) {
      final match = RegExp(
        pattern,
        caseSensitive: false,
        multiLine: true,
      ).firstMatch(title);
      final value = match?.group(1)?.padLeft(pad, '0');
      return value != null ? '$prefix$value' : null;
    }

    final v = parse(r'\bvol(?:\.|umes?)\s*(\d{1,3})\b', 'V', 2);
    final s = parse(r'\bs(?:easons?)?\s*(\d{1,3})\b', 'S', 2);
    final e = parse(r'\be(?:p|pisodes?)?\s*(\d{1,3})\b', 'E', 2);

    final allValue = [v, s, e].whereType<String>().join();
    if (allValue.isEmpty) {
      return title;
    } else {
      return '$allValue - $title';
    }
  }

  int get duration {
    final duration = contentDetails.duration;
    final regex = RegExp(r'^P(?:(\d+)D)?T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?$');

    final match = regex.firstMatch(duration);
    if (match == null) return 0;

    final days = int.tryParse(match.group(1) ?? '0') ?? 0;
    final hours = int.tryParse(match.group(2) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(3) ?? '0') ?? 0;
    final seconds = int.tryParse(match.group(4) ?? '0') ?? 0;

    return days * 86400 + hours * 3600 + minutes * 60 + seconds;
  }

  String formatDuration() {
    final duration = Duration(seconds: this.duration);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      return "$hours:${minutes.toString().padLeft(2, '0')}:$seconds";
    } else {
      return "$minutes:$seconds";
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'video': video.toJson(),
      'snippet': snippet.toJson(),
      'thumbnails': thumbnails.toJson(),
      'contentDetails': contentDetails.toJson(),
      'status': status.toJson(),
      'statistics': statistics.toJson(),
      'progressData': progressData.toJson(),
      'channel': channel.toJson(),
    };
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      video: Video.fromJson(json['video'] as Map<String, dynamic>),
      snippet: VideoSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
      thumbnails: VideoThumbnail.fromJson(json['thumbnails'] as Map<String, dynamic>),
      contentDetails: VideoContentDetail.fromJson(
        json['contentDetails'] as Map<String, dynamic>,
      ),
      status: VideoStatuse.fromJson(json['status'] as Map<String, dynamic>),
      statistics: VideoStatistic.fromJson(json['statistics'] as Map<String, dynamic>),
      progressData: VideoProgressData.fromJson(
        json['progressData'] as Map<String, dynamic>,
      ),
      channel: ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
    );
  }
}
