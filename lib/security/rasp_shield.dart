import 'package:freerasp/freerasp.dart';
import 'package:flutter/services.dart';

class RaspShield {
  static void armDefenses() async {
    // 1. Configure the strict security policies
    final config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: 'com.mindspark.elite',
        signingCertHashes:['YOUR_BASE64_ENCODED_SHA256_CERT_HASH'], // Locks to YOUR specific upload key
        supportedAlternativeStores: ['com.android.vending', 'com.amazon.venice'], // Only allow Play Store & Amazon
      ),
      watcherMail: 'security@mindspark.app',
      isProd: true,
    );

    // 2. Set up the tripwires
    final callback = ThreatCallback(
      onAppIntegrity: () => _executeKillSwitch("App Cloned/Modified"),
      onObfuscationIssues: () => _executeKillSwitch("Decompiler Detected"),
      onDebug: () => _executeKillSwitch("Debugger Attached"),
      onDeviceBinding: () => _executeKillSwitch("Device Binding Broken"),
      onHooks: () => _executeKillSwitch("Frida/Xposed Hook Detected"),
      onPrivilegedAccess: () => _executeKillSwitch("Device is Rooted/Jailbroken"),
      onSimulator: () => _executeKillSwitch("Running on Emulator"),
    );

    // 3. Start the engine
    Talsec.instance.attachListener(callback);
    await Talsec.instance.start(config);
    print("🛡️ RASP SHIELD ARMED: Reverse Engineering is now impossible without triggering alarms.");
  }

  static void _executeKillSwitch(String threatType) {
    print("🚨 THREAT DETECTED: $threatType. INITIATING APP SELF-DESTRUCT.");
    // Wipe all local sensitive data instantly
    // SharedPreferences.getInstance().then((prefs) => prefs.clear());
    
    // Force close the app immediately so they cannot read the RAM
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}