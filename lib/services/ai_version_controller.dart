import 'package:supabase_remote_config/supabase_remote_config.dart';

class AiVersionController {
  static final FirebaseRemoteConfig _rc = FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    // 1. Setup infinite polling - check for updates every 1 minute
    await _rc.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    // 2. Set dynamic defaults
    await _rc.setDefaults({
      "latest_openai_model": "gpt-4o",
      "latest_gemini_model": "gemini-1.5-pro",
      "latest_groq_model": "llama-3.1-70b-versatile",
    });

    // 3. Initial Activation
    await _rc.fetchAndActivate();

    // 4. INFINITE REAL-TIME UPDATES
    // This listens for any change you make in the Firebase Console instantly
    _rc.onConfigUpdated.listen((event) async {
      await _rc.activate();
      print("🚀 BRAIN UPGRADED: Models synced to newest cloud versions.");
    });
  }

  // INFINITE GETTERS: These always return the most recent cloud value
  static String get openAiModel => _rc.getString('latest_openai_model');
  static String get geminiModel => _rc.getString('latest_gemini_model');
  static String get groqModel => _rc.getString('latest_groq_model');

  // FOR SIMULTANEOUS FETCHING (used by your SparkAiCore)
  static Future<void> syncModels() async {
    await _rc.fetchAndActivate();
  }
}
