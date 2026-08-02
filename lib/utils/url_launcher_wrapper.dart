import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherWrapper {
  /// Opens external hypermedia links using an optimized single-parse execution pipeline
  static Future<void> open(String urlString) async {
    if (urlString.isEmpty) return;

    try {
      // 1. Instantly parses the string exactly once to prevent memory overhead
      final Uri url = Uri.parse(urlString.trim());

      // 2. Uses launchUrl with a mode override to bypass strict OS visibility bottlenecks safely
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // Forces execution directly to native external browsers
      );
    } catch (e) {
      // Graceful fallback prevents the application UI thread from snapping if deep links are malformed
      debugPrint("UrlLauncher Error: Cannot launch link sequence -> ${e.toString()}");
    }
  }
}
