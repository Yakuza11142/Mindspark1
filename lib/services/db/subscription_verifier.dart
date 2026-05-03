import 'package:supabase_flutter/supabase_flutter.dart';

class SubscriptionVerifier {
  static Future<void> updateProStatusInCloud(bool isPro) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    await Supabase.instance.client.from('profiles').update({
      'is_pro': isPro,
      'pro_updated_at': DateTime.now().toIso8601String(),
    }).eq('id', user.id);
  }
}