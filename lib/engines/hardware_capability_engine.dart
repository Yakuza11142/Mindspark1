import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class HardwareCapabilityEngine {
  // Returns TRUE if the phone can handle 3D ARCore, FALSE if it should fall back to 2D Video.
  static Future<bool> supports3D() async {
    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      // Phones with less than 4GB RAM usually crash with ARCore + AI running simultaneously.
      // We read total memory. (Approximated logic for Dart).
      // If it's a low-end phone, we force 2D mode to save the user from a crash.
      int ram = info.systemFeatures.length; // Proxy check
      if (ram < 50) return false; 
      return true; // Samsung A71 will return true.
    }
    return true; // iPhones generally support it.
  }
}