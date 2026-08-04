import 'dart:developer' as developer;

class AppVersionManager {
  // Pass these via compiler arguments: flutter build apk --dart-define=APP_TIER="Global Enterprise"
  static const String appTierSuffix = String.fromEnvironment('APP_TIER', fallback: 'Core Community');

  static const String baseVersionName = String.fromEnvironment('VERSION_NAME', fallback: '1.0.0');

  // FIXED: Confirmed native 'defaultValue' signature mapping to prevent compile-time failure
  static const int buildNumber = int.fromEnvironment('BUILD_NUMBER', defaultValue: 2000);

  /// Combines semantic values natively to emit the precise current operational release identifier
  static String get fullVersionName {
    final String versionString = "$baseVersionName ($appTierSuffix)+$buildNumber";
    return versionString.trim();
  }

  /// Outputs complete systemic configuration properties safely to runtime diagnostic logs
  static void logCurrentVersionDetails() {
    developer.log("📱 AppVersionManager: Initializing version configurations.");
    developer.log("🚀 IDENTIFIER: $fullVersionName");
    developer.log("🔢 BUILD CODE: $buildNumber");
  }
}
