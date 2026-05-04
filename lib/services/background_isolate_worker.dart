import 'dart:isolate';
import 'dart:convert';

class BackgroundIsolateWorker {
  static Future<Map<String, dynamic>> parseMassiveJson(String rawJson) async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_decodeJson, [receivePort.sendPort, rawJson]);
    return await receivePort.first as Map<String, dynamic>;
  }

  static void _decodeJson(List<dynamic> args) {
    SendPort sendPort = args[0];
    String rawJson = args[1];
    Map<String, dynamic> result = jsonDecode(rawJson);
    sendPort.send(result);
  }
}