import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceSpoofDetector {
  // Centralized hardware signatures used by popular emulators (Genymotion, BlueStacks, Corellium)
  static const List<String> _emulatorKeywords = [
    'google_sdk', 'emulator', 'android sdk', 'sdk_gphone', 
    'goldfish', 'ranchu', 'vbox86', 'nox', 'bluestacks', 
    'vmos', 'andy', 'amiduos', 'ko player', 'ldplayer'
  ];

  /// Performs deep fingerprint validation checks to verify if the client environment is emulated
  static Future<bool> isEmulator() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      
      // Tier 1: Hardware-reported flag verification
      if (!androidInfo.isPhysicalDevice) return true;

      // Tier 2: Deep Build property inspection for hardware anomalies
      final String hardware = androidInfo.hardware.toLowerCase();
      final String product = androidInfo.product.toLowerCase();
      final String model = androidInfo.model.toLowerCase();
      final String brand = androidInfo.brand.toLowerCase();
      final String device = androidInfo.device.toLowerCase();
      final String fingerprint = androidInfo.fingerprint.toLowerCase();
      final String board = androidInfo.board.toLowerCase();

      // Look for specific emulator keyword signatures across system properties
      for (final String keyword in _emulatorKeywords) {
        if (hardware.contains(keyword) ||
            product.contains(keyword) ||
            model.contains(keyword) ||
            brand.contains(keyword) ||
            device.contains(keyword) ||
            fingerprint.contains(keyword) ||
            board.contains(keyword)) {
          return true;
        }
      }

      // Tier 3: Architecture and developer-build heuristics anomalies
      if (fingerprint.startsWith('unknown') || board.startsWith('unknown')) {
        return true;
      }
      
      // Generic Android Studio emulator pipeline defaults
      if (hardware == 'goldfish' || hardware == 'ranchu') return true;

    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      
      // Standard iOS simulator fallback path check
      if (!iosInfo.isPhysicalDevice) return true;
    }

    return false;
  }
}
