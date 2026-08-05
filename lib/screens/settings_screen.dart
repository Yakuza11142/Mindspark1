import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'legal_screen.dart';
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

  // Safe wrapped URL execution protects app thread from crashing out when devices lack target software handles.
  Future<void> _safeLaunchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Could not open link: $urlString")),
          );
        }
      }
    } catch (exception) {
      debugPrint("⚠️ Web protocol engine failure: $exception");
    }
  }

  // Added explicit interactive user alert view for updating parent emails.
  void _showUpdateEmailDialog() {
    final TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text("Update Parent Email"),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "Enter parent's email address"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Parent email address updated safely.")),
                );
              }
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white)), 
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          _header("PREFERENCES"),
          SwitchListTile(
            title: const Text("Daily Study Reminders", style: TextStyle(color: Colors.white)),
            subtitle: const Text("Get notified at 6:00 PM", style: TextStyle(color: Colors.grey)),
            secondary: const Icon(Icons.notifications, color: Colors.amber),
            value: _notifications,
            onChanged: (bool val) {
              setState(() => _notifications = val);
              if (val) {
                NotificationService().scheduleDailyReminder();
              } else {
                NotificationService().cancelAll();
              }
            },
          ),
          SwitchListTile(
            title: const Text("Haptic Feedback", style: TextStyle(color: Colors.white)),
            subtitle: const Text("Vibrate on button clicks", style: TextStyle(color: Colors.grey)),
            secondary: const Icon(Icons.vibration, color: Colors.cyan),
            value: _haptics,
            onChanged: (bool val) => setState(() => _haptics = val),
          ),

          _header("ACCOUNT"),
          ListTile(
            leading: const Icon(Icons.restore, color: Colors.green),
            title: const Text("Restore Purchases", style: TextStyle(color: Colors.white)),
            onTap: () => PaymentService().buyPro(), 
          ),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.white),
            title: const Text("Update Parent Email", style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            onTap: _showUpdateEmailDialog,
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.purple),
            title: const Text("Legal & Privacy", style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => const LegalScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text("Delete Account Data", style: TextStyle(color: Colors.white)),
            subtitle: const Text("Wipe all history and data permanently", style: TextStyle(color: Colors.grey)),
            onTap: () => _confirmDelete(),
          ),

          _header("SUPPORT"),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue),
            title: const Text("Help Center & FAQ", style: TextStyle(color: Colors.white)),
            onTap: () => _safeLaunchUrl("https://mindspark.com/faq"),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.purple),
            title: const Text("Privacy Policy", style: TextStyle(color: Colors.white)),
            onTap: () => _safeLaunchUrl("https://mindspark.com/privacy"),
          ),
          ListTile(
            leading: const Icon(Icons.support, color: Colors.blue),
            title: const Text("Contact Support", style: TextStyle(color: Colors.white)),
            onTap: () => _safeLaunchUrl("mailto:support@mindspark.com"),
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.orange),
            title: const Text("Share MindSpark", style: TextStyle(color: Colors.white)),
            onTap: () {
              try {
                Share.share("Download MindSpark! The AI Tutor. https://mindspark.com");
              } catch (exception) {
                debugPrint("⚠️ Native share interface call exception: $exception");
              }
            },
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
      child: Text(
        text, 
        style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text("Delete Everything?"),
        content: const Text("This cannot be undone. All Sparks and History will be lost."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              LegalService.wipeUserData(); 
              Navigator.pop(ctx); 
              Navigator.pop(context); 
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Wiped.")),
                );
              }
            }, 
            child: const Text("DELETE", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
