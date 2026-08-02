import 'package:http/http.dart' as http;

Future<bool> checkAdBlockActive() async {
  try {
    // Web browsers use Honeypot network requests to catch script blockers instantly
    final url = Uri.parse('https://googlesyndication.com');
    final response = await http.get(url).timeout(const Duration(seconds: 3));
    
    return response.statusCode != 200;
  } catch (_) {
    return true; // Extension blocked script injection request completely
  }
}
