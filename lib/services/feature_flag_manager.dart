class FeatureFlagManager {
  static bool isFeatureEnabled(String featureKey) {
    // e.g., 'enable_christmas_theme' or 'enable_voice_chat'
    return SupabaseRemoteConfig.instance.getBool(featureKey);
  }
}
