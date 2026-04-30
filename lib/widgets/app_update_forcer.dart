import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateForcer extends StatelessWidget {
  final String playStoreUrl;
  const AppUpdateForcer({super.key, required this.playStoreUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.system_update, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text("CRITICAL UPDATE REQUIRED", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("MindSpark has evolved. Please update to the latest version to access the new Neural Matrix.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(playStoreUrl))) await launchUrl(Uri.parse(playStoreUrl));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
              child: const Text("UPDATE NOW", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}