import 'package:bingetube/core/api/youtube_data.dart';
import 'package:flutter/material.dart';

class YoutubePlayerController {
  final YouTubeVideo data;

  YoutubePlayerController({required this.data});
}

class YoutubePlayerWidget extends StatelessWidget {
  final YoutubePlayerController controller;

  const YoutubePlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
