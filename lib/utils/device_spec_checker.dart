import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceSpecChecker {
  static Future<bool> isLowEnd() async {
    if (Platform.isAndroid) {
      var info = await DeviceInfoPlugin().androidInfo;
      // If RAM is less than 3GB (approx), consider low end
      // Note: totalMem is in bytes. 3GB = 3 * 1024^3
      return info.totalMemory < 3221225472; 
    }
    return false;
  }
}