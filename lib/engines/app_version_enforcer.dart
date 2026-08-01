import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class AppVersionEnforcer {
  // Singleton pattern minimizes global footprint and protects multi-threaded memory spaces [INDEX]
  AppVersionEnforcer._internal();
  static final AppVersionEnforcer instance = AppVersionEnforcer._internal();

  static const int _fallbackMinBuild = 1700;
  
  // Explicit mathematical transaction caps protect your accounting structures against extreme integer injection errors [INDEX]
  static const int _maximumReasonableBuildCeiling = 100000;

  // Class properties isolated cleanly within the specific instance scope [INDEX]
  int _remoteMinimumRequiredBuild = _fallbackMinBuild;

  /// Fetches the latest system version compliance parameters from a remote config microservice [INDEX]
  Future<void> syncMinimumVersionRequirements(String remoteConfigUrl) async {
    developer.log("⚙️ VersionEnforcer: Syncing minimum build rules from remote configuration mapping.");
    
    try {
      final http.Response response = await http.get(
        Uri.parse(remoteConfigUrl),
        headers: {"Accept": "application/json"},
      ).timeout(
        const Duration(seconds: 4), 
      );

      if (response.statusCode == 200) {
        final dynamic decodedJson = jsonDecode(response.body);
        if (decodedJson is Map) {
          final Map<String, dynamic> configMap = Map<String, dynamic>.from(decodedJson);
          
          final int? remoteBuild = int.tryParse(configMap['minimum_required_build'].toString());
          
          // Appended rigid upper-bound boundary checks to prevent rogue server parameters from locking out your user base [INDEX]
          if (remoteBuild != null && remoteBuild > 0 && remoteBuild <= _maximumReasonableBuildCeiling) {
            _remoteMinimumRequiredBuild = remoteBuild;
            developer.log("✅ VersionEnforcer: Dynamic update threshold securely applied: $_remoteMinimumRequiredBuild");
            return;
          }
        }
      }
      throw Exception("Invalid configuration footprint returned from server gateway.");
    } catch (e, stack) {
      developer.log("⚠️ VersionEnforcer: Failed to fetch remote configurations. Reverting to local fallback asset rules.", error: e, stackTrace: stack);
      _remoteMinimumRequiredBuild = _fallbackMinBuild; 
    }
  }

  /// Verifies if a specific incoming build allocation matches system monetization and safety conditions [INDEX]
  bool isBuildSupported(int currentLocalBuild) {
    if (currentLocalBuild <= 0) return false;
    
    final bool passesCompliance = currentLocalBuild >= _remoteMinimumRequiredBuild;
    if (!passesCompliance) {
      developer.log("🚨 VersionEnforcer: Client version mismatch detected! Build $currentLocalBuild is deprecated. Required minimum: $_remoteMinimumRequiredBuild");
    }
    return passesCompliance;
  }

  /// Explicit property getter lets testing matrices audit current live system states cleanly [INDEX]
  int get activeMinimumThreshold => _remoteMinimumRequiredBuild;
}
