import 'package:shared_preferences/shared_preferences.dart';

class DynamicPaywallRouter {
  static Future<double> getCustomPrice() async {
    final prefs = await SharedPreferences.getInstance();
    int paywallViews = prefs.getInt('paywall_views') ?? 0;
    await prefs.setInt('paywall_views', paywallViews + 1);

    if (paywallViews > 3) return 2500.0; // Discounted Nigerian Price
    return 4500.0; // Standard Nigerian Price
  }
}