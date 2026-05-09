import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.system_update, size: 80, color: Colors.amber),
            const Text("Update Required"),
            ElevatedButton(onPressed: () => launchUrl(Uri.parse("https://play.google.com")), child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}