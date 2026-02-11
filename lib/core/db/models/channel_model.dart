import 'package:bingetube/core/db/database.dart';

class ChannelModel {
  final Channel channel;
  final ChannelSnippet snippet;
  final ChannelThumbnail thumbnails;
  final ChannelContentDetail contentDetails;
  final ChannelStatistic statistics;
  final ChannelStatuse status;

  ChannelModel({
    required this.channel,
    required this.snippet,
    required this.thumbnails,
    required this.contentDetails,
    required this.statistics,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'channel': channel.toJson(),
      'snippet': snippet.toJson(),
      'thumbnails': thumbnails.toJson(),
      'contentDetails': contentDetails.toJson(),
      'statistics': statistics.toJson(),
      'status': status.toJson(),
    };
  }

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      channel: Channel.fromJson(json['channel'] as Map<String, dynamic>),
      snippet: ChannelSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
      thumbnails: ChannelThumbnail.fromJson(
        json['thumbnails'] as Map<String, dynamic>,
      ),
      contentDetails: ChannelContentDetail.fromJson(
        json['contentDetails'] as Map<String, dynamic>,
      ),
      statistics: ChannelStatistic.fromJson(
        json['statistics'] as Map<String, dynamic>,
      ),
      status: ChannelStatuse.fromJson(json['status'] as Map<String, dynamic>),
    );
  }
}
