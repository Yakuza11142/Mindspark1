import 'package:ntp/ntp.dart';

class TimeSyncEngine {
  static DateTime? _secureTime;

  static Future<void> syncWithServer() async {
    try {
      _secureTime = await NTP.now(lookUpAddress: 'time.google.com');
      print("Secure Time Synced: $_secureTime");
    } catch (e) {
      _secureTime = DateTime.now(); // Fallback
    }
  }

  static DateTime getSecureNow() {
    return _secureTime ?? DateTime.now();
  }
}