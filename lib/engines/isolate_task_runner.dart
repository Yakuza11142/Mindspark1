import 'dart:isolate';

class IsolateTaskRunner {
  static Future<int> runHeavyMath(int data) async {
    ReceivePort port = ReceivePort();
    await Isolate.spawn(_heavyTask, [port.sendPort, data]);
    return await port.first;
  }
  static void _heavyTask(List<dynamic> args) {
    SendPort port = args[0];
    // Heavy calculation
    port.send(args[1] * 2);
  }
}