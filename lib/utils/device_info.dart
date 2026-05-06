import 'dart:io';

class DeviceInfo {
  static String getPlatform() {
    if (Platform.isAndroid) return "Android Device";
    if (Platform.isIOS) return "iOS Device";
    return "Unknown Platform";
  }
}