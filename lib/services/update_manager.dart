import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class UpdateManager {
  // Centralized configurations preventing string hardcoding errors across systems
  static const String _tableVersionControl = 'app_version_control';
  static const String _columnStableVersion = 'latest_stable_version';
  static const String _fallbackVersion = '1.0.0';

  /// Evaluates local software tags against Supabase deployment versioning arrays to flag pending updates.
  static Future<bool> isUpdateAvailable() async {
    try {
      // 1. Extract local platform installation metadata variables from the device
      final PackageInfo platformPackageDetails = await PackageInfo.fromPlatform();
      final String clientCurrentVersionString = platformPackageDetails.version.trim();

      if (clientCurrentVersionString.isEmpty) {
        return false;
      }

      // 2. Fetch the latest live operational version threshold from your backend storage table
      final List<Map<String, dynamic>> backendQueryResponse = await Supabase.instance.client
          .from(_tableVersionControl)
          .select(_columnStableVersion)
          .limit(1);

      if (backendQueryResponse.isEmpty) {
        developer.log("⚠️ Update Control: Version check table is empty or inaccessible.");
        return false;
      }

      final String remoteTargetVersionString = 
          backendQueryResponse.first[_columnStableVersion] ?? _fallbackVersion;

      developer.log("🔍 Update Control: Checking Client ($clientCurrentVersionString) vs Server ($remoteTargetVersionString)");

      // 3. Process a clean semantic comparison array check to verify update eligibility
      return _compareSemanticVersions(clientCurrentVersionString, remoteTargetVersionString);
    } catch (error, stackTrace) {
      // Enforce framework isolation: Ensure unexpected database dropouts never crash app launch workflows
      developer.log(
        "🚨 Update Control Failure: Problem communicating with remote version verification servers.",
        error: error,
        stackTrace: stackTrace,
      );
      
      // Fail-open: Let the user enter the app normally if the server check encounters an exception
      return false; 
    }
  }

  /// Parses semantic dot-notation strings to evaluate version hierarchies cleanly
  static bool _compareSemanticVersions(String clientVersion, String serverVersion) {
    final List<int> clientParts = clientVersion.split('.').map((part) => int.tryParse(part) ?? 0).toList();
    final List<int> serverParts = serverVersion.split('.').map((part) => int.tryParse(part) ?? 0).toList();

    // Standardize comparison widths across minor version patterns (e.g., matching 1.0 vs 1.0.0)
    final int maxComparisonWidth = clientParts.length > serverParts.length ? clientParts.length : serverParts.length;

    for (int i = 0; i < maxComparisonWidth; i++) {
      final int clientSegmentValue = i < clientParts.length ? clientParts[i] : 0;
      final int serverSegmentValue = i < serverParts.length ? serverParts[i] : 0;

      if (serverSegmentValue > clientSegmentValue) {
        return true; // Server version is newer; update is available
      } else if (clientSegmentValue > serverSegmentValue) {
        return false; // Client version is newer or beta build; skip update flag
      }
    }

    return false; // Versions match exactly
  }
}
