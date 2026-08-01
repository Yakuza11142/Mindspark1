import 'dart:io';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:developer' as developer;

class AppIntegrityShield {
  // Centralized package registry constants ensuring zero raw-string duplication
  static const String _androidGooglePlay = 'com.android.vending';
  static const String _androidAmazonStore = 'com.amazon.venezia';
  static const String _iosAppStore = 'com.apple';
  static const String _iosTestFlight = 'com.apple.testflight';

  /// Evaluates app installation source metadata asynchronously to detect side-loaded APKS
  static Future<bool> verifyInstaller() async {
    try {
      final PackageInfo systemPackageDetails = await PackageInfo.fromPlatform();
      final String? derivedStoreId = systemPackageDetails.installerStore;

      // An empty/null installer source signature implies a manual side-loaded ADB / file install
      if (derivedStoreId == null || derivedStoreId.trim().isEmpty) {
        return false;
      }

      if (Platform.isAndroid) {
        // Enforce validations against trusted official marketplace vendors
        return derivedStoreId == _androidGooglePlay || 
               derivedStoreId == _androidAmazonStore;
      } else if (Platform.isIOS) {
        // Enforce apple sandbox/receipt pathing validations
        return derivedStoreId == _iosAppStore || 
               derivedStoreId == _iosTestFlight;
      }

      // Default fail-secure fallback strategy for unmapped operating system targets
      return false;
    } on PlatformException catch (exception, stackTrace) {
      developer.log(
        "🚨 Integrity Shield Failure: System blocked access to device Package Manager metadata.",
        error: exception,
        stackTrace: stackTrace,
      );
      
      // Fail-secure: Treat runtime channel communication issues as an unauthorized ecosystem signature
      return false;
    } catch (genericError) {
      return false;
    }
  }
}
