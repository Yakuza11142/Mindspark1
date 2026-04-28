import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InAppUpdater {
  static Future<void> checkForUpdates(BuildContext context) async {
    try {
      // 1. Get the current version of the app on the student's phone
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      int currentBuildNumber = int.parse(packageInfo.buildNumber); // e.g., 1

      // 2. Check Supabase for the latest version you uploaded
      final response = await Supabase.instance.client
          .from('system_config')
          .select('latest_build_number, update_url, release_notes')
          .single();

      int latestBuild = response['latest_build_number'];
      String updateUrl = response['update_url']; // Link to your new APK or Play Store
      String notes = response['release_notes']; // e.g., "Added Stadium AR!"

      // 3. If their app is old, throw the Update Screen
      if (currentBuildNumber < latestBuild) {
        if (context.mounted) {
          _showUpdateDialog(context, updateUrl, notes);
        }
      }
    } catch (e) {
      print("Update check failed. Letting user continue.");
    }
  }

  static void _showUpdateDialog(BuildContext context, String url, String notes) {
    showDialog(
      context: context,
      barrierDismissible: false, // Forces them to update
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.cyanAccent)),
        title: const Row(
          children:[
            Icon(Icons.system_update_alt, color: Colors.cyanAccent, size: 30),
            SizedBox(width: 10),
            Text("UPDATE REQUIRED", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Text("A massive new upgrade is available for MindSpark Elite.", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 15),
            Text("What's New:\n$notes", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ],
        ),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              }
            },
            child: const Text("DOWNLOAD UPDATE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}