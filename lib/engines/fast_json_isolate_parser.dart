import 'dart:isolate';
import 'dart:convert';

class FastJsonIsolateParser {
  static Future<Map<String, dynamic>> parseHeavyJson(String jsonString) async {
    ReceivePort port = ReceivePort();
    await Isolate.spawn(_decode, [port.sendPort, jsonString]);
    return await port.first;
  }
  static void _decode(List<dynamic> args) {
    SendPort port = args[0];
    port.send(jsonDecode(args[1]));
  }
}