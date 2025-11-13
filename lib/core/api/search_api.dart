import 'dart:convert';
import 'package:bingetube/core/api/youtube_data.dart';
import 'package:http/http.dart' as http;

class SearchApi {
  static Future<List<YouTubeChannel>?> searchYouTubeChannels(
    String query,
    String apiKey,
  ) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search'
      '?part=snippet'
      '&q=${Uri.encodeQueryComponent(query)}'
      '&type=channel'
      '&maxResults=10'
      '&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final items = (data['items'] as List?) ?? [];
      return items.map((item) => YouTubeChannel.fromJson(item)).toList();
    } else {
      return null;
    }
  }
}
