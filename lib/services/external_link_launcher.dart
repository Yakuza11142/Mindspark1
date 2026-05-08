import 'package:url_launcher/url_launcher.dart';

class LinkLauncher {
  static void open(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}