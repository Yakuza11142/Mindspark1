import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class AbTestManager {
  static Future<String> getVariant(String testName) async {
    final deviceInfo = DeviceInfoPlugin();
    String hwId = Platform.isAndroid ? (await deviceInfo.androidInfo).id : "IOS";
    
    try {
      final res = await Supabase.instance.client.rpc('get_ab_variant', params: {'p_hw_id': hwId, 'p_test': testName});
      return res as String;
    } catch (e) {
      return "A"; // Default fallback
    }
  }
}