import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class ScreenRecordingBlocker {
  static Future<void> secureVideoPlayback() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    print("🔒 Screen recording and screenshots blocked for Premium Video.");
  }
  
  static Future<void> release() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }
}