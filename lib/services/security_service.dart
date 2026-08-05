import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class SecurityService {
  // 1. CHECK FOR HACKERS (Root/Jailbreak)
  static Future<bool> isDeviceCompromised() async {
    bool jailbroken = false;

    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      jailbroken = true; // Assume the worst if checking fails
    }

    return jailbroken;
  }

  // 2. KILL SWITCH
  static void killApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
