import 'dart:isolate';

class BackgroundIsolateKiller {
  static void kill(Isolate isolate) {
    isolate.kill(priority: Isolate.immediate);
    print("Runaway thread terminated.");
  }
}