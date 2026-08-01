import 'dart:developer' as developer;

class AppVersionManager {
  // Migrated plain literal strings to dynamic build-time environment variable lookups [INDEX]
  // Pass these effortlessly via compiler arguments: flutter build apk --dart-define=APP_TIER="Global Enterprise"
  static const String appTierSuffix = String.fromEnvironment('APP_TIER', fallback: 'Core Community');
  
  static const String baseVersionName = String.fromEnvironment('VERSION_NAME', fallback: '1.0.0');
  
  // Bound build tracking numbers to systemic integer environments to allow seamless CI/CD injection loops [INDEX]
  static const int buildNumber = int.fromEnvironment('BUILD_NUMBER', fallback: 2000);

  /// Combines semantic values natively to emit the precise current operational release identifier [INDEX]
  static String get fullVersionName {
    final String versionString = "$baseVersionName ($appTierSuffix)+$buildNumber";
    return versionString.trim();
  }

  /// Outputs complete systemic configuration properties safely to runtime diagnostic logs [INDEX]
  static void logCurrentVersionDetails() {
    developer.log("📱 AppVersionManager: Initializing version configurations.");
    developer.log("🚀 IDENTIFIER: $fullVersionName");
    developer.log("🔢 BUILD CODE: $buildNumber");
  }
}
