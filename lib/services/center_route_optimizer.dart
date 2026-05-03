import 'package:url_launcher/url_launcher.dart';

class CenterRouteOptimizer {
  static void openCachedRoute(String centerAddress) async {
    print("Opening offline-saved Google Maps route to $centerAddress...");
    String url = "google.navigation:q=${Uri.encodeComponent(centerAddress)}&mode=d";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}