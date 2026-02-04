import 'dart:io';
import 'package:bingetube/core/constants/assets.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/services.dart' show rootBundle;

class PlayerServer {
  static final _instance = PlayerServer._internal();
  static final _logger = LogManager.getLogger('PlayerServer');

  factory PlayerServer() {
    return _instance;
  }

  PlayerServer._internal();

  HttpServer? _server;
  int _port = 0;

  int get port => _port;
  bool get isRunning => _server != null;

  Future<void> start() async {
    if (_server != null) return;

    try {
      _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      _port = _server!.port;

      _server!.listen((HttpRequest request) async {
        await _handleRequest(request);
      });

      _logger.info('PlayerServer running on http://localhost:$_port');
    } catch (e) {
      _logger.severe('Failed to start PlayerServer: $e');
    }
  }

  Future<void> stop() async {
    await _server?.close(force: true);
    _server = null;
    _port = 0;
    _logger.severe('PlayerServer stopped');
  }

  Future<void> _handleRequest(HttpRequest request) async {
    try {
      final data = await rootBundle.load(Assets.playerHtml.path);
      final bytes = data.buffer.asUint8List();

      request.response
        ..headers.contentType = ContentType.html
        ..contentLength = bytes.length
        ..add(bytes);
    } catch (e) {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Player asset not found');
    } finally {
      await request.response.close();
    }
  }
}
