class YouTubeChannel {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;

  YouTubeChannel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory YouTubeChannel.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    return YouTubeChannel(
      id: snippet['channelId'] ?? '',
      title: snippet['title'] ?? '',
      description: snippet['description'] ?? '',
      thumbnailUrl: snippet['thumbnails']?['default']?['url'] ?? '',
    );
  }
}

class YouTubeVideo {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;
  final String channelId;
  final DateTime publishedAt;

  YouTubeVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.channelId,
    required this.publishedAt,
  });

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    return YouTubeVideo(
      id: json['id']?['videoId'] ?? '',
      title: snippet['title'] ?? '',
      description: snippet['description'] ?? '',
      thumbnailUrl:
          snippet['thumbnails']?['high']?['url'] ??
          snippet['thumbnails']?['default']?['url'] ??
          '',
      channelTitle: snippet['channelTitle'] ?? '',
      channelId: snippet['channelId'] ?? '',
      publishedAt:
          DateTime.tryParse(snippet['publishedAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
