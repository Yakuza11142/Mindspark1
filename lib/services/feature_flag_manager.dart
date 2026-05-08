import 'package:supabase_remote_config/supabase_remote_config.dart';

class FeatureFlagManager {
  static bool isFeatureEnabled(String featureKey) {
    // e.g., 'enable_christmas_theme' or 'enable_voice_chat'
    return SupabaseRemoteConfig.instance.getBool(featureKey);
  }
}