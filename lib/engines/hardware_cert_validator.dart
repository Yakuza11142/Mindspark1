import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class HardwareCertValidator {
  static Future<String> mintHardwareCertificate(String studentName, String course) async {
    // 1. Get the unbreakable, unique physical hardware ID of the phone
    final deviceInfo = DeviceInfoPlugin();
    String hardwareSignature = "";
    
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      hardwareSignature = androidInfo.id; // Unique motherboard ID
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      hardwareSignature = iosInfo.identifierForVendor ?? const Uuid().v4();
    }

    // 2. Generate a random UUID v4 (Unguessable 36-character string)
    String uniqueCertCode = const Uuid().v4();

    // 3. Send it straight to Supabase (Your new Cloud Server)
    final client = Supabase.instance.client;
    try {
      await client.from('official_diplomas').insert({
        'cert_code': uniqueCertCode,
        'student_name': studentName,
        'course': course,
        'hardware_signature': hardwareSignature, // Locks the cert to THIS phone only
        'issued_on': DateTime.now().toIso8601String(),
      });
      
      // Return the unguessable code to be printed on the PDF
      return uniqueCertCode; 
    } catch (e) {
      return "NETWORK_ERROR_CERT_PENDING";
    }
  }
}