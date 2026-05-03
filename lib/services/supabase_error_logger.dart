import '../config/supabase_core_config.dart';

class SupabaseErrorLogger {
  static Future<void> logCrash(String error, String stackTrace) async {
    try {
      await SupabaseCoreConfig.client.from('crash_logs').insert({
        'error_msg': error,
        'stack_trace': stackTrace,
        'device_os': 'Android',
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Failed to log error to cloud.");
    }
  }
}