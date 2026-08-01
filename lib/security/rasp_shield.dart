import 'dart:async';
import 'package:freerasp/freerasp.dart';
import 'package:flutter/services.dart';

class RaspShield {
  // Saved stream subscription reference container to manage background resources safely
  static StreamSubscription<Threat>? _threatStreamSubscription;

  static void armDefenses() async {
    // 1. Configure the strict security policies
    final config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: 'com.mindspark.elite',
        signingCertHashes: [
          'YOUR_BASE64_ENCODED_SHA256_CERT_HASH'
        ], // Locks to YOUR specific upload key
        supportedAlternativeStores: [
          'com.android.vending',
          'com.amazon.venice'
        ], // Only allow Play Store & Amazon
      ),
      watcherMail: 'security@mindspark.app',
      isProd: true,
    );

    // 2. Set up modern threat stream listener to capture security signals dynamically
    _threatStreamSubscription = Talsec.instance.onThreatDetected.listen((Threat threat) {
      switch (threat) {
        case Threat.appIntegrity:
          _executeKillSwitch("App Cloned/Modified");
        case Threat.obfuscationIssues:
          _executeKillSwitch("Decompiler Detected");
        case Threat.debug:
          _executeKillSwitch("Debugger Attached");
        case Threat.deviceBinding:
          _executeKillSwitch("Device Binding Broken");
        case Threat.hooks:
          _executeKillSwitch("Frida/Xposed Hook Detected");
        case Threat.privilegedAccess:
          _executeKillSwitch("Device is Rooted/Jailbroken");
        case Threat.simulator:
          _executeKillSwitch("Running on Emulator");
        default:
          // Optional: Catch-all block for modern capabilities like Threat.systemVPN, Threat.devMode, etc.
          _executeKillSwitch("Unknown Device Integrity Violation");
      }
    });

    // 3. Start the protection engine
    await Talsec.instance.start(config);
    print("🛡️ RASP SHIELD ARMED: Continuous behavioral threat monitoring active.");
  }

  /// Shuts down background listeners cleanly if your security module ever unloads
  static void disarmDefenses() {
    _threatStreamSubscription?.cancel();
    _threatStreamSubscription = null;
  }

  static void _executeKillSwitch(String threatType) {
    print("🚨 THREAT DETECTED: $threatType. INITIATING APP TERMINATION.");
    
    // Force close the app immediately so they cannot dump the system RAM
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
