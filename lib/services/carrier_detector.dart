// Requires 'carrier_info' package
import 'package:carrier_info/carrier_info.dart';

class CarrierDetector {
  static Future<String> getNetworkName() async {
    try {
      CarrierData? carrierInfo = await CarrierInfo.all;
      return carrierInfo?.mobileNetworkOperator?.networkName ?? "WiFi/Unknown";
    } catch (e) {
      return "Unknown";
    }
  }

  static Future<bool> isMtnUser() async {
    String name = await getNetworkName();
    return name.toLowerCase().contains('mtn');
  }
}