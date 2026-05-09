import 'dart:io';

class PlatformCheck {
  static bool get isAmazon => Platform.isAndroid && (File('/system/framework/com.google.android.maps.jar').existsSync() == false);
}