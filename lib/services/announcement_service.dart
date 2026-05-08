import 'package:http/http.dart' as http;
import 'dart:convert';

class AnnouncementService {
  // Replace with a raw JSON link you control
  static const String url = "https://your-config-url.json"; 

  static Future<String?> checkForNews() async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data['show'] == true) return data['message'];
      }
    } catch (e) { return null; }
    return null;
  }
}