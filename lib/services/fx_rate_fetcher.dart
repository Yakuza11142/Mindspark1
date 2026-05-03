import 'dart:convert';
import 'package:http/http.dart' as http;

class FxRateFetcher {
  // Uses a free public API for exchange rates
  static Future<double> getRate(String targetCurrency) async {
    try {
      final res = await http.get(Uri.parse("https://open.er-api.com/v6/latest/USD"));
      if (res.statusCode == 200) {
        var rates = jsonDecode(res.body)['rates'];
        return rates[targetCurrency] ?? 1.0;
      }
    } catch (e) {
      return 1.0; // Fallback to USD 1:1 if offline
    }
    return 1.0;
  }
}