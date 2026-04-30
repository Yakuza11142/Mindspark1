import 'dart:convert';
import 'package:http/http.dart' as http;

class GlobalTelcoZeroRating {
  static Future<Map<String, dynamic>> checkIspStatus() async {
    try {
      final res = await http.get(Uri.parse("https://api.ipify.org?format=json"));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        String isp = data['isp'].toString().toLowerCase();
        
        // GLOBAL TELECOM PARTNERS
        List<String> partners =["mtn", "airtel", "safaricom", "vodafone", "jio", "t-mobile", "orange", "o2"];
        
        for (String partner in partners) {
          if (isp.contains(partner)) {
            print("📡 Global ISP Detected: ${partner.toUpperCase()}. Zero-Rating Active.");
            return {"isSponsored": true, "carrier": partner.toUpperCase()};
          }
        }
      }
      return {"isSponsored": false, "carrier": "Unknown"};
    } catch (e) {
      return {"isSponsored": false, "carrier": "Offline"};
    }
  }
}