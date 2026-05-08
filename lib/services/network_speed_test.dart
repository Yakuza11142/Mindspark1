import 'dart:io';

class NetworkSpeedTest {
  static Future<bool> isFastConnection() async {
    final stopwatch = Stopwatch()..start();
    try {
      await InternetAddress.lookup('google.com');
      stopwatch.stop();
      return stopwatch.elapsedMilliseconds < 200; // < 200ms is good
    } catch (_) {
      return false;
    }
  }
}