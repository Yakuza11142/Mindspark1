import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_device/safe_device.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class MindSparkEngine {
  static Future<void> start() async {
    // --- PART 1: THE BUG KILLER (Global Error Handling) ---
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint("Bug Caught & Isolated: ${details.exception}");
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      debugPrint("Background Bug Killed: $error");
      return true; // Prevents app from crashing
    };

    // --- PART 2: THE SHIELD (Anti-Hacker Protection) ---
    await _runSecurityCheck();
  }

  static Future<void> _runSecurityCheck() async {
    try {
      bool isRooted = await FlutterJailbreakDetection.jailbroken;
      bool isDev = await FlutterJailbreakDetection.developerMode;
      bool isReal = await SafeDevice.isRealDevice;

      // If it's a hacker's environment or an untrusted device, kill the app immediately
      if (isRooted || isDev || !isReal) {
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        exit(0);
      }
    } catch (exception) {
      // If the security plug-in architecture itself fails or runs on an unsupported test machine,
      // fallback safely instead of crashing out the layout thread.
      debugPrint("Security structural pass verification exception: $exception");
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    await MindSparkEngine.start();
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    debugPrint("Top-level Bug Killed: $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: Scaffold());
}