import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ArDependencyChecker {
  static void checkAndPrompt(BuildContext context) {
    // If the AR button does nothing, the user clicks "Fix AR" which triggers this
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text("AR Engine Missing", style: TextStyle(color: Colors.redAccent)),
        content: const Text("Your phone needs 'Google Play Services for AR' to project 3D holograms. Please update or install it from the Play Store.", style: TextStyle(color: Colors.white)),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
            onPressed: () async {
              const url = "https://play.google.com/store/apps/details?id=com.google.ar.core";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              }
            }, 
            child: const Text("INSTALL AR ENGINE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          )
        ],
      )
    );
  }
}