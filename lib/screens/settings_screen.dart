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
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../services/payment_service.dart';
import '../services/legal_service.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _haptics = true;
  bool _sound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("Settings"), backgroundColor: Colors.transparent),
      body: ListView(
        children: [
          // SECTION 1: PREFERENCES
          _header("PREFERENCES"),
          SwitchListTile(
            title: const Text("Daily Study Reminders"),
            subtitle: const Text("Get notified at 6:00 PM"),
            secondary: const Icon(Icons.notifications, color: Colors.amber),
            value: _notifications,
            onChanged: (val) {
              setState(() => _notifications = val);
              if (val) NotificationService().scheduleDailyReminder();
              else NotificationService().cancelAll();
            },
          ),
          SwitchListTile(
            title: const Text("Haptic Feedback"),
            subtitle: const Text("Vibrate on button clicks"),
            secondary: const Icon(Icons.vibration, color: Colors.cyan),
            value: _haptics,
            onChanged: (val) => setState(() => _haptics = val),
          ),

          // SECTION 2: ACCOUNT
          _header("ACCOUNT"),
          ListTile(
            leading: const Icon(Icons.restore, color: Colors.green),
            title: const Text("Restore Purchases"),
            onTap: () => PaymentService().buyPro(), // Triggers restore logic
          ),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.white),
            title: const Text("Update Parent Email"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              // Show Dialog to edit email
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text("Delete Account"),
            subtitle: const Text("Wipe all history and data"),
            onTap: () => _confirmDelete(),
          ),

          // SECTION 3: SUPPORT
          _header("SUPPORT"),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue),
            title: const Text("Help Center & FAQ"),
            onTap: () => launchUrl(Uri.parse("https://mindspark.com/faq")),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.purple),
            title: const Text("Privacy Policy"),
            onTap: () => launchUrl(Uri.parse("https://mindspark.com/privacy")),
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.orange),
            title: const Text("Share MindSpark"),
            onTap: () => Share.share("Download MindSpark! The AI Tutor. https://mindspark.com"),
          ),
          
          const SizedBox(height: 40),
          const Center(child: Text("Version 1.0.0 (Build 405)", style: TextStyle(color: Colors.grey))),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _header(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(text, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Everything?"),
        content: const Text("This cannot be undone. All Sparks and History will be lost."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              LegalService.wipeUserData(); // Calls the legal wipe function
              Navigator.pop(ctx);
              // Navigate to Login/Splash
            }, 
            child: const Text("DELETE", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}