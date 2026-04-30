import 'package:flutter/foundation.dart';

class PlatformDetectorOmni {
  static bool get isMobile => defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android;
  static bool get isDesktop => defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux;
  static bool get isWeb => kIsWeb;
}