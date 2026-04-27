import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'legal_screen.dart';
import '../services/legal_service.dart';
import '../services/currency_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.purple),
            title: const Text("Legal & Privacy"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text("Delete Account Data"),
            onTap: () {
              LegalService.wipeUserData();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data Wiped.")));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.support, color: Colors.blue),
            title: const Text("Contact Support"),
            onTap: () => launchUrl(Uri.parse("mailto:support@mindspark.com")),
          ),
        ],
      ),
    );
  }
}