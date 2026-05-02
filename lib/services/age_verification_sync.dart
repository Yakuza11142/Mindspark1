import 'package:supabase_flutter/supabase_flutter.dart';

class AgeVerificationSync {
  static Future<void> syncToCloud(int birthYear) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      await Supabase.instance.client.from('profiles').update({'birth_year': birthYear}).eq('id', user.id);
    }
  }
}