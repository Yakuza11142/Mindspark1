import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_device/safe_device.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class MindSparkEngine {
  static Future<void> start() async {
    // --- PART 1: THE BUG KILLER (Global Error Handling) ---
    // This catches every "Red Screen of Death" bug and keeps the app running
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      print("Bug Caught & Isolated: ${details.exception}");
      // Log bug to Supabase here if needed
    };

    // This catches bugs in background tasks (Asynchronous bugs)
    PlatformDispatcher.instance.onError = (error, stack) {
      print("Background Bug Killed: $error");
      return true; // Prevents app from crashing
    };

    // --- PART 2: THE SHIELD (Anti-Hacker Protection) ---
    await _runSecurityCheck();
  }

  static Future<void> _runSecurityCheck() async {
    bool isRooted = await FlutterJailbreakDetection.jailbroken;
    bool isDev = await FlutterJailbreakDetection.developerMode;
    bool isReal = await SafeDevice.isRealDevice;

    // If it's a hacker's environment, kill the app immediately
    if (isRooted || isDev || !isReal) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    }
  }
}
void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Start Protection and Bug Killer
    await MindSparkEngine.start();

    runApp(const MyApp());
  }, (error, stack) {
    print("Top-level Bug Killed: $error");
  });
}
