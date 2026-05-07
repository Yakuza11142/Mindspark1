import 'dart:convert';
import 'package:http/http.dart' as http;

class RegionDetectorService {
  static Future<String> getCountryCode() async {
    try {
      final res = await http.get(Uri.parse("http://ip-api.com/json/"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body)['countryCode']; // e.g., 'US', 'NG', 'GB'
      }
    } catch (e) {
      return 'US'; // Fallback
    }
    return 'US';
  }
}