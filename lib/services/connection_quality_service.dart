import 'dart:io';

class ConnectionQualityService {
  static Future<bool> isConnectionGood() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
  
  static Future<int> getLatency() async {
    final stopwatch = Stopwatch()..start();
    try {
      await InternetAddress.lookup('google.com');
      stopwatch.stop();
      return stopwatch.elapsedMilliseconds;
    } catch (e) {
      return 9999;
    }
  }
}