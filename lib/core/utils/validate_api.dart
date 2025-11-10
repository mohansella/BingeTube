import 'dart:convert';
import 'package:http/http.dart' as http;

class ValidateApi {
  Future<bool> validateYouTubeApiKey(String apiKey) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/channels?part=id&forHandle=@youtube&key=$apiKey',
    );

    final response = await http.get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['items'] != null && data['items'].isNotEmpty;
    }
    return false;
  }
}
