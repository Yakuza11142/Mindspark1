import 'package:url_launcher/url_launcher.dart';

class SafeUrlLauncher {
  static Future<void> open(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}