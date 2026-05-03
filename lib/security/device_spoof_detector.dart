import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceSpoofDetector {
  static Future<bool> isEmulator() async {
    if (Platform.isAndroid) {
      var info = await DeviceInfoPlugin().androidInfo;
      return !info.isPhysicalDevice;
    }
    return false;
  }
}