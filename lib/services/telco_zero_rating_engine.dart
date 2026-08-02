import 'dart:io';
import 'package:flutter/services.dart';
import 'package:carrier_info/carrier_info.dart';
import 'dart:developer' as developer;

class TelcoZeroRatingEngine {
  // Mobile Network Codes (MNC) for major Nigerian telecommunications providers
  // 01, 13 = MTN Nigeria | 12, 14 = Airtel Nigeria
  static const List<String> _sponsoredMncCodes = ['01', '13', '12', '14'];
  
  // Mobile Country Code (MCC) for Nigeria is 621
  static const String _nigeriaMccCode = '621';

  /// Examines native physical SIM infrastructure to confirm zero-rating telecom partnership statuses.
  static Future<bool> isDataSponsored() async {
    try {
      // Hardware requirement guard: Telephony abstractions require explicit phone environments
      if (!Platform.isAndroid && !Platform.isIOS) {
        return false;
      }

      // Fetch network parameters straight from the system radio connection controller
      final AndroidCarrierData? androidData = Platform.isAndroid ? await CarrierInfo.getAndroidData() : null;
      final IosCarrierData? iosData = Platform.isIOS ? await CarrierInfo.getIosData() : null;

      String? activeMcc;
      String? activeMnc;

      if (Platform.isAndroid && androidData != null) {
        // Collect network details from the active cell tower connection channel
        activeMcc = androidData.telephonyInfo.firstOrNull?.mcc;
        activeMnc = androidData.telephonyInfo.firstOrNull?.mnc;
      } else if (Platform.isIOS && iosData != null) {
        // Collect network details from the cellular service provider profile mappings
        activeMcc = iosData.carrierData.firstOrNull?.mobileCountryCode;
        activeMnc = iosData.carrierData.firstOrNull?.mobileNetworkCode;
      }

      if (activeMcc == null || activeMnc == null) {
        developer.log("📡 Zero-Rating Engine: Unable to safely resolve cellular radio network parameters.");
        return false;
      }

      // Verify if the SIM matches Nigerian carrier infrastructure boundaries
      if (activeMcc.trim() != _nigeriaMccCode) {
        return false;
      }

      // Match the network code against your zero-rated carrier configurations
      final bool isMatchFound = _sponsoredMncCodes.contains(activeMnc.trim());

      if (isMatchFound) {
        developer.log("📡 Zero-Rating Shield: Verified MTN/Airtel SIM connection pattern. Activating sponsored asset paths.");
        return true;
      }

      return false;
    } on PlatformException catch (platformException, stackTrace) {
      developer.log(
        "🚨 Zero-Rating Engine Failure: Device OS rejected request to query hardware carrier configurations.",
        error: platformException,
        stackTrace: stackTrace,
      );
      return false; // Fallback to safe default pricing boundaries
    } catch (genericError) {
      return false;
    }
  }
}
