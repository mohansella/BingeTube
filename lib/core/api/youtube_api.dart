import 'dart:convert';
import 'package:bingetube/core/config/apikey_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:bingetube/core/api/youtube_data.dart';

class YoutubeApi {
  static Future<bool> validateYouTubeApiKey(String apiKey) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/channels?part=id&forHandle=@youtube&key=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['items'] != null && data['items'].isNotEmpty;
    }
    return false;
  }

  static Future<List<YouTubeChannel>?> searchChannels(
    WidgetRef ref,
    String apiKey,
    String query,
  ) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search'
      '?part=snippet'
      '&q=${Uri.encodeQueryComponent(query)}'
      '&type=channel'
      '&maxResults=50'
      '&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      ApiKeyUtil.addQuota(ref, .searchChannel, 100);
      final data = json.decode(response.body);
      final items = (data['items'] as List?) ?? [];
      return items.map((item) => YouTubeChannel.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<List<YouTubeVideo>?> searchVideos(
    WidgetRef ref,
    String apiKey,
    String query,
  ) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search'
      '?part=snippet'
      '&q=${Uri.encodeQueryComponent(query)}'
      '&type=video'
      '&maxResults=50'
      '&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      ApiKeyUtil.addQuota(ref, .searchVideo, 100);
      final data = json.decode(response.body);
      final items = (data['items'] as List?) ?? [];
      return items
          .where((item) {
            return item['id']['kind'] == 'youtube#video';
          })
          .map((item) => YouTubeVideo.fromJson(item))
          .toList();
    } else {
      return null;
    }
  }
}
