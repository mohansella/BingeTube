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
