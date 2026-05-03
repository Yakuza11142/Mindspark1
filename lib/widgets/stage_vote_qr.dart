import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "VOTING & ACCESS",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          
          // Your QR Code inside a Settings Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Scan to Vote (Abuja Live)",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  QrImageView(
                    data: "https://mindspark.app/abuja-live",
                    size: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Point your camera at the screen",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          const Divider(),
          
          // Other common settings options
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Account Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
