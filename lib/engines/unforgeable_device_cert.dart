import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class CloudCertResponse {
  final String sha256;
  final String sha512;
  CloudCertResponse(this.sha256, this.sha512);
}

class UnforgeableDeviceCert {
  static Future<CloudCertResponse> generateIroncladHash(String studentName, String course) async {
    final deviceInfo = DeviceInfoPlugin();
    String hardwareId = "UNKNOWN";

    // 1. Get Hardware ID
    if (Platform.isAndroid) {
      hardwareId = (await deviceInfo.androidInfo).id;
    } else if (Platform.isIOS) {
      hardwareId = (await deviceInfo.iosInfo).identifierForVendor ?? "IOS";
    }

    final timestamp = DateTime.now().toIso8601String();
    final salt = "SUNBUILT_ELITE_2026";
    final rawData = "$studentName|$course|$hardwareId|$timestamp|$salt";
    final bytes = utf8.encode(rawData);

    // 2. Generate Dual Hashes
    final hash256 = sha256.convert(bytes).toString();
    final hash512 = sha512.convert(bytes).toString();

    // 3. Sync to Cloud (Supabase)
    try {
      await Supabase.instance.client.from('issued_certs').insert({
        'student_name': studentName,
        'course': course,
        'device_id': hardwareId,
        'hash_256': hash256,
        'hash_512': hash512,
        'created_at': timestamp,
      });
    } catch (e) {
      print("Cloud Sync Failed: $e");
    }

    return CloudCertResponse(hash256, hash512);
  }
}
import 'package:device_info_plus/device_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class UnforgeableDeviceCert {
  /// Calls a Supabase Edge Function to generate hashes. 
  /// The "Secret Salt" stays hidden in the Cloud, invisible to hackers.
  static Future<Map<String, dynamic>> generateCloudLockedCert(String studentName, String course) async {
    final deviceInfo = DeviceInfoPlugin();
    String hardwareId = "UNKNOWN";

    if (Platform.isAndroid) {
      hardwareId = (await deviceInfo.androidInfo).id;
    } else if (Platform.isIOS) {
      hardwareId = (await deviceInfo.iosInfo).identifierForVendor ?? "IOS";
    }

    try {
      // Use Supabase Functions to do the heavy lifting safely in the cloud
      final response = await Supabase.instance.client.functions.invoke(
        'generate-secure-cert',
        body: {
          'name': studentName,
          'course': course,
          'hw_id': hardwareId,
        },
      );

      // Returns the SHA-256 and SHA-512 generated on the server
      return response.data; 
    } catch (e) {
      throw Exception("Security Breach or Offline: Could not verify device.");
    }
  }
}
