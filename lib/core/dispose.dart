import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/http/http_client.dart';

sealed class CoreDispose {
  static bool _isDisposed = false;
  static Future<void> disposeAll() async {
    if (_isDisposed) {
      throw StateError('Already BingeTube disposed');
    }
    //database
    var db = Database();
    await db.close();

    //client
    CoreClient.dispose();

    _isDisposed = true;
  }
}
