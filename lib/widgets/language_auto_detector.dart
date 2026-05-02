import 'dart:ui' as ui;

class LanguageAutoDetector {
  static String getPrimaryLanguage() {
    return ui.PlatformDispatcher.instance.locale.languageCode; // e.g., 'en', 'fr', 'hi'
  }
}