import 'dart:io';

class LocalLanServer {
  static HttpServer? _server;

  static Future<void> startServer() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
    print("📡 Local Mesh Server running on: ${_server!.address.address}:8080");

    _server!.listen((HttpRequest request) {
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write('{"status": "MindSpark Node Active", "shared_lessons": 14}')
        ..close();
    });
  }

  static void stopServer() => _server?.close();
}