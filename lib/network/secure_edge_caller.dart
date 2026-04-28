import 'package:supabase_flutter/supabase_flutter.dart';

class SecureEdgeCaller {
  static Future<void> requestMtnData(String phoneNumber) async {
    await Supabase.instance.client.functions.invoke(
      'mtn-zero-rating',
      body: {'phone_number': phoneNumber, 'user_id': Supabase.instance.client.auth.currentUser?.id},
    );
  }
}