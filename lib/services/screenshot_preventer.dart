import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:ios_insecure_screen_detector/ios_insecure_screen_detector.dart'; // Add this to pubspec

class GlobalSecurityService extends WidgetsBindingObserver {
  // Singleton Pattern
  static final GlobalSecurityService _instance = GlobalSecurityService._internal();
  factory GlobalSecurityService() => _instance;
  GlobalSecurityService._internal();

  final IosInsecureScreenDetector _iosDetector = IosInsecureScreenDetector();
  bool _isScreenRecording = false;

  /// Initialize global listeners
  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    
    // Listen specifically for iOS Screen Recording/Mirroring
    _iosDetector.addListener(() {
      _isScreenRecording = _iosDetector.isCaptured;
      // You can trigger a global 'Security Alert' here if recording is detected
    });
    
    secureApp();
  }

  /// Activates platform-level blocking (Android) and UI-level alerts (iOS)
  Future<void> secureApp() async {
    // Android: Blocks screenshots, screen recordings, and recent app previews
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    
    // iOS: Starts the detection service
    _iosDetector.initialize();
  }

  /// Removes protection for specific areas (e.g., viewing public certificates)
  Future<void> unsecureApp() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  /// Professional "Glass Blur" Overlay
  /// Wrap your sensitive screens with this widget.
  Widget secureOverlay({required Widget child}) {
    return ListenableBuilder(
      listenable: _iosDetector,
      builder: (context, _) {
        if (_iosDetector.isCaptured) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                "SECURITY PROTOCOL ACTIVE\nScreen recording is strictly prohibited.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
