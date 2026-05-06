import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pqcrypto/pqcrypto.dart'; 
import 'package:thirds/sha3.dart';
import 'package:safe_device/safe_device.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class AppSecurity {
  // --- QUANTUM-SAFE HASHING (SHA-3) ---
  // Use this to secure any internal data strings
  static String quantumHash(String data) {
    return sha3_512.convert(utf8.encode(data)).toString();
  }

  // --- CRYPTOGRAPHIC INTEGRITY CHECK ---
  // Detects if the app is running in a hacked or fake environment
  static Future<void> verifyEnvironment() async {
    bool isRooted = await FlutterJailbreakDetection.jailbroken;
    bool isDev = await FlutterJailbreakDetection.developerMode;
    bool isReal = await SafeDevice.isRealDevice;

    // Kills the app if a hacker environment is detected
    if (isRooted || isDev || !isReal) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0); 
    }
  }

  // --- POST-QUANTUM VERIFICATION (ML-DSA) ---
  // Checks if any internal module has been tampered with
  static Future<bool> isDataValid(String data, String signatureB64, String publicKeyB64) async {
    try {
      final sig = base64.decode(signatureB64);
      final key = base64.decode(publicKeyB64);
      return await MLDSA.verify(utf8.encode(data), sig, key);
    } catch (e) {
      return false;
    }
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Activate environment protection immediately
  await AppSecurity.verifyEnvironment();

  runApp(const Mind SparkApp());
}
