import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class CeoHardwareLock {
  // 🚨 YOU MUST REPLACE THIS WITH YOUR PHONE'S ACTUAL ID LATER
  // I will show you how to find your phone's ID in Step 3.
  static const String myCeoDeviceId = "352641110567091"; 

  static Future<bool> verifyCeoDevice() async {
    final deviceInfo = DeviceInfoPlugin();
    String currentDeviceId = "352641110567091";

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        currentDeviceId = androidInfo.id; // The unchangeable Android Motherboard ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        currentDeviceId = iosInfo.identifierForVendor ?? "";
      }

      print("Checking Hardware ID: $currentDeviceId");

      // THE ULTIMATE LOCK: Does the device holding the app match the CEO's device?
      if (currentDeviceId == myCeoDeviceId) {
        return true; // Access Granted
      } else {
        print("🚨 INTRUSION ATTEMPT: Unauthorized device tried to access CEO Dashboard.");
        return false; // Access Denied
      }
    } catch (e) {
      return false; // Fail safe: block access if hardware cannot be verified
    }
  }
}