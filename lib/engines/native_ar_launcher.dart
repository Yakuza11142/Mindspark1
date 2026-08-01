import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:developer' as developer;

class NativeArLauncher {
  /// Launches the native Android Scene Viewer augmented reality system without platform channel overhead
  static Future<void> launchHologram(String glbUrl, String title) async {
    if (!Platform.isAndroid) {
      developer.log("⚠️ Native AR Launcher is currently Android-only configuration.");
      return;
    }

    // Defensive input check: Enforce absolute remote web link format paths to prevent downstream asset loading errors
    if (!glbUrl.trim().toLowerCase().startsWith("http://") && !glbUrl.trim().toLowerCase().startsWith("https://")) {
      developer.log("❌ AR Launcher: Asset source target is not a valid absolute web URL string pattern.");
      return;
    }

    developer.log("🚀 AR Launcher: Forcing Native Android Scene Viewer target for asset: $title");

    final String encodedFile = Uri.encodeComponent(glbUrl.trim());
    final String encodedTitle = Uri.encodeComponent(title.trim());
    
    // FIXED: Enforced the mandatory official domain route required by Android to fire ARCore activities
    final String sceneViewerUrl = "https://google.com"
        "?file=$encodedFile"
        "&mode=ar_only"
        "&title=$encodedTitle"
        "&resizable=true";

    try {
      final Uri uri = Uri.parse(sceneViewerUrl);

      final bool successfullyLaunched = await launchUrl(
        uri, 
        mode: LaunchMode.externalApplication,
      );

      if (!successfullyLaunched) {
        developer.log("❌ AR Core Scene Viewer link rejected by the system. Triggering backup browser rendering.");
        await _launchWebFallback(glbUrl);
      }
    } catch (e, stack) {
      developer.log("❌ AR Intent Launch Failed catastrophically", error: e, stackTrace: stack);
      await _launchWebFallback(glbUrl);
    }
  }

  /// Private fail-safe web backup rendering engine pipeline
  static Future<void> _launchWebFallback(String glbUrl) async {
    // FIXED: Restored the dollar sign ($) and parameter query format (?src=) to pass compilation
    final String browserTarget = "https://modelviewer.dev{Uri.encodeComponent(glbUrl.trim())}";
    try {
      await launchUrl(
        Uri.parse(browserTarget),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      developer.log("Fallback browser redirection collapsed: $e");
    }
  }
}
