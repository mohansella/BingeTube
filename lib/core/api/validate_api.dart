import 'dart:convert';
import 'package:http/http.dart' as http;

class ValidateApi {

  static Future<bool> validateTest(String apiKey) async {
    await Future.delayed(Duration(seconds: 2));
    if(apiKey.isEmpty) {
      return false;
    }
    return true;
  }
  
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
}
