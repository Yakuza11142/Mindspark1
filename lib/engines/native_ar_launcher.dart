import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class NativeArLauncher {
  static Future<void> launchHologram(String glbUrl, String title) async {
    if (!Platform.isAndroid) {
      print("Native AR Launcher is currently Android-only.");
      return;
    }

    print("🚀 Bypassing Flutter... Forcing Native Android Scene Viewer for: $title");

    // The Magic Intent URI for Google Scene Viewer
    // This tells Android: "Open the AR app, download this 3D file, and put it on the floor."
    final String intentUri = 
      "intent://arvr.google.com/scene-viewer/1.0"
      "?file=${Uri.encodeComponent(glbUrl)}"
      "&mode=ar_only"
      "&title=${Uri.encodeComponent(title)}"
      "&resizable=true"
      "#Intent;scheme=https;package=com.google.ar.core;action=android.intent.action.VIEW;S.browser_fallback_url=https://developers.google.com/ar;end;";

    try {
      final Uri uri = Uri.parse(intentUri);
      
      // Launch Mode externalApplication forces it out of the Flutter sandbox
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print("❌ CRITICAL: Google ARCore is missing or disabled on this device.");
        // Fallback: Just open the 3D model in a normal web browser
        await launchUrl(Uri.parse("https://modelviewer.dev/?src=${Uri.encodeComponent(glbUrl)}"));
      }
    } catch (e) {
      print("AR Intent Launch Failed: $e");
    }
  }
}