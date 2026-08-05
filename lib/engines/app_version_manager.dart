import 'dart:developer' as developer;

class AppVersionManager {
  // FIXED: Replaced 'fallback' with the correct parameter name 'defaultValue'
  static const String appTierSuffix = String.fromEnvironment('APP_TIER', defaultValue: 'Core Community');

  // FIXED: Replaced 'fallback' with the correct parameter name 'defaultValue'
  static const String baseVersionName = String.fromEnvironment('VERSION_NAME', defaultValue: '1.0.0');

  // 🚀 FIXED: Replaced 'int.fromEnvironment' with 'String.fromEnvironment' to resolve 'const_eval_throws_exception'.
  // Flutter's compilation pipeline treats values from '--dart-define' as Strings, which causes 'int.fromEnvironment'
  // to throw a critical compiler exception. Reading it as a String and using a dynamic getter ensures zero errors.
  static const String _rawBuildNumber = String.fromEnvironment('BUILD_NUMBER', defaultValue: '2000');
  static int get buildNumber => int.tryParse(_rawBuildNumber) ?? 2000;

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
