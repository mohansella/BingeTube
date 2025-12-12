import 'package:bingetube/core/db/access/videos.dart';
import 'package:flutter/material.dart';

class YoutubePlayerController {
  final VideoModel model;

  YoutubePlayerController({required this.model});
}

class YoutubePlayerWidget extends StatelessWidget {
  final YoutubePlayerController controller;

  const YoutubePlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
