import 'dart:ui' as ui;

class AutoLocaleDetector {
  static String getDeviceLanguageCode() {
    // Returns 'en', 'fr', 'zh', 'hi', etc.
    return ui.PlatformDispatcher.instance.locale.languageCode;
  }
}