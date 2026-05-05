import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupabaseCore {
  // Your real Supabase URL and Anon Key (Get this free at supabase.com)
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  // Production-ready data insertion with offline fallback
  static Future<void> securelySaveScore(String userId, int score, String exam) async {
    final client = Supabase.instance.client;
    try {
      await client.from('exam_results').insert({
        'user_id': userId,
        'exam_type': exam,
        'score': score,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // IF NETWORK FAILS (Bank/Server down), SAVE TO DEVICE RAM/STORAGE
      final prefs = await SharedPreferences.getInstance();
      List<String> offlineQueue = prefs.getStringList('offline_scores') ??[];
      offlineQueue.add('{"uid":"$userId","exam":"$exam","score":$score}');
      await prefs.setStringList('offline_scores', offlineQueue);
    }
  }
}