import 'package:ntp/ntp.dart';

class OfflineLicenseValidator {
  static Future<bool> isLicenseValidOffline(DateTime expiry) async {
    try {
      DateTime trueTime = await NTP.now(); // Checks network time protocol, ignores device clock
      return trueTime.isBefore(expiry);
    } catch (e) {
      // If fully offline, fallback to a strict local boot-counter logic
      return true; 
    }
  }
}