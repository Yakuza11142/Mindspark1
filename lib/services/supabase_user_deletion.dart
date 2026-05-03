import '../config/supabase_core_config.dart';

class SupabaseUserDeletion {
  static Future<void> deleteMyAccount() async {
    // Edge function must be used to bypass RLS and delete Auth user securely
    await SupabaseCoreConfig.client.functions.invoke('delete_user_account');
    await SupabaseCoreConfig.client.auth.signOut();
  }
}