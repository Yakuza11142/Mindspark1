import 'package:http/http.dart' as http;
import 'dart:convert';

class TelcoZeroRatingEngine {
  static Future<bool> isDataSponsored() async {
    try {
      // Connect to an IP detection service or your own backend
      final res = await http.get(Uri.parse("https://api.ipify.org?format=json"));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        String isp = data['isp'].toString().toLowerCase();
        
        // If the user is on MTN Nigeria or Airtel Networks, activate Zero Rating
        if (isp.contains("mtn") || isp.contains("airtel")) {
          print("📡 MTN/Airtel Detected. Zero-Rating Active. No data charges apply.");
          return true;
        }
      }
      return false;
    } catch (e) {
      return false; // Fallback to normal data usage
    }
  }
}