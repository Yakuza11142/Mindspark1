import 'package:flutter/material.dart';

class SystemThemeListener with WidgetsBindingObserver {
  @override
  void didChangePlatformBrightness() {
    print("OS Theme changed. Adapting MindSpark UI...");
  }
}