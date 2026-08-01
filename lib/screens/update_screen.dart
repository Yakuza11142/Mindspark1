import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

class UpdateScreen extends StatelessWidget {
  // Central source of truth for app bundle package strings across store ecosystems [INDEX]
  static const String _appBundlePackageId = "com.mindspark.app";
  static const String _iosAppStoreId = "6470000000"; // Explicit Apple Developer App Store ID [INDEX]

  const UpdateScreen({super.key});

  /// Safely routes users straight to the native platform app store page without browser layout steps [INDEX]
  Future<void> _launchStorefrontListing(BuildContext context) async {
    developer.log("⚙️ UpdateScreen: Processing deep-link redirect sequence for package identifier.");

    // FIXED: Formulated absolute platform-native intent scheme URIs to target the app markets explicitly [INDEX]
    final Uri marketUri = Uri.parse("market://details?id=$_appBundlePackageId");
    final Uri iOSMarketUri = Uri.parse("itms-apps://://apple.com");
    
    // FIXED: Repaired fallbacks to ensure they route straight to your specific application's web listings [INDEX]
    final Uri fallbackWebUri = Uri.parse("https://google.com");
    final Uri fallbackIosWebUri = Uri.parse("https://apple.com");

    try {
      // 1. Core Android Native Market Deep-Link Route Track [INDEX]
      if (await canLaunchUrl(marketUri)) {
        await launchUrl(
          marketUri,
          mode: LaunchMode.externalApplication, 
        );
        return;
      }
      
      // 2. Core iOS Native App Store Deep-Link Route Track [INDEX]
      if (await canLaunchUrl(iOSMarketUri)) {
        await launchUrl(
          iOSMarketUri,
          mode: LaunchMode.externalApplication,
        );
        return;
      }
      
      // 3. Web Store fallback paths handle sandbox environments without native store apps installed [INDEX]
      developer.log("⚠️ UpdateScreen: Native market schemes unsupported. Falling back to web listing links.");
      
      // Select the correct web store domain based on low-level platform constraints [INDEX]
      final bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
      final Uri targetWebUri = isAndroid ? fallbackWebUri : fallbackIosWebUri;

      await launchUrl(
        targetWebUri,
        mode: LaunchMode.platformDefault,
      );
    } catch (e, stackTrace) {
      developer.log("❌ UpdateScreen: Asynchronous platform intent tracking loops collapsed seamlessly", error: e, stackTrace: stackTrace);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to open the App Store. Please check network configurations.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.system_update_rounded, size: 85, color: Colors.amberAccent),
                const SizedBox(height: 25),
                const Text(
                  "Update Required",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  "We have deployed critical optimization patches and performance enhancements. Please upgrade your application layout version to keep mastering lessons.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.white60, height: 1.4),
                ),
                const SizedBox(height: 45),
                ElevatedButton.icon(
                  icon: const Icon(Icons.download_rounded, size: 20),
                  label: const Text("UPGRADE NOW", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 10,
                  ),
                  onPressed: () => _launchStorefrontListing(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
