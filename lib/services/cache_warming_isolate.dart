import 'dart:isolate';

class CacheWarmingIsolate {
  static void warmUp() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_heavyTask, receivePort.sendPort);
  }

  static void _heavyTask(SendPort sendPort) {
    // Preload heavy JSON lists here
    sendPort.send("Cache Warmed");
  }
}