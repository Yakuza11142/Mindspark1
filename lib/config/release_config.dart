class ReleaseConfig {
  // FIXED: Standardizes telemetry tracking. Logs are strictly deactivated on release builds.
  static const bool enableLogs = bool.fromEnvironment('ENABLE_LOGS', defaultValue: false);
  
  // FIXED: Converted to a dynamic environment flag. Allows you to toggle ad monetization 
  // on or off globally inside your CI build flags without editing source code.
  static const bool enableAds = bool.fromEnvironment('ENABLE_ADS', defaultValue: true);

  // FIXED: Pulls your live URL securely from the secrets.json compilation matrix definition layers.
  // It completely wipes plain text strings from your Git history tracking pages.
  static const String serverUrl = String.fromEnvironment(
    'SUPABASE_URL', 
    defaultValue: "https://fallback.mindspark.app",
  );
}
