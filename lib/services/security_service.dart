// Placeholder for jailbreak logic
class SecurityService {
  static Future<bool> isSafe() async {
    return true; // Use flutter_jailbreak_detection in prod
  }
}
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class SecurityService {
  // 1. CHECK FOR HACKERS (Root/Jailbreak)
  static Future<bool> isDeviceCompromised() async {
    bool jailbroken = false;
    bool developerMode = false;

    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      // We allow developer mode for you to test, but you can block it later
      // developerMode = await FlutterJailbreakDetection.developerMode; 
    } on PlatformException {
      jailbroken = true; // Assume the worst if check fails
    }

    return jailbroken;
  }

  // 2. KILL SWITCH
  static void killApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}