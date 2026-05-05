import 'dart:isolate';

class BackgroundIsolateParser {
  static Future<String> parseHeavyEquation(String equation) async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_heavyCompute, receivePort.sendPort);
    return await receivePort.first as String;
  }

  static void _heavyCompute(SendPort sendPort) {
    // Simulate heavy math formatting
    sendPort.send("Equation Parsed Successfully");
  }
}