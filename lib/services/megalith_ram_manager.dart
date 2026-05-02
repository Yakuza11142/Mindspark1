import 'dart:isolate';

class MegalithRamManager {
  static Future<void> preWarmMegalith() async {
    ReceivePort port = ReceivePort();
    await Isolate.spawn(_warmup, port.sendPort);
    await port.first;
    print("🧠 Omni-Data Megalith fully loaded into RAM.");
  }
  static void _warmup(SendPort port) {
    // Accessing the class forces Dart to compile it into memory
    String test = "Warmup";
    port.send(test);
  }
}