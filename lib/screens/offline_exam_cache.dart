import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/supabase_core_config.dart';

class OfflineExamManager {
  OfflineExamManager._internal();
  static final OfflineExamManager instance = OfflineExamManager._internal();

  /// Fetches 5 Mock Exams and stores them locally as an encoded JSON string
  Future<void> cacheForSurvival() async {
    final prefs = await SharedPreferences.getInstance();
    
    try {
      // 1. Fetch from Supabase (Cloud)
      final List<dynamic> exams = await SupabaseCoreConfig.client
          .from('mock_exams')
          .select('*')
          .limit(5);

      // 2. Serialize to JSON and save locally
      await prefs.setString('offline_exams_blob', jsonEncode(exams));
      await prefs.setBool('is_offline_ready', true);
      
      print("📦 Survival Cache Locked: 5 Exams stored locally.");
    } catch (e) {
      print("❌ Cache Failed: Check internet connection.");
    }
  }

  /// Retrieves the cached exams when internet is gone
  Future<List<dynamic>> getCachedExams() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('offline_exams_blob');
    return encodedData != null ? jsonDecode(encodedData) : [];
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseCoreConfig.initialize();

  // Background sync for offline survival
  GlobalOfflineManager.instance.syncSurvivalCache();

  runApp(const MyApp());
}
