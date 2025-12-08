import 'package:http/http.dart';

sealed class CoreClient {
  static final Client _client = Client();

  static Future<Response> get(Uri url, {Map<String, String>? headers}) {
    return _client.get(url, headers: headers);
  }

  static void dispose() {
    _client.close();
  }
}
