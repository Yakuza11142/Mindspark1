import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/currency_manager.dart';

class SocialFollowDialog extends StatelessWidget {
  const SocialFollowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E293B),
      title: const Text("Follow MindSpark!", style: TextStyle(color: Colors.white)),
      content: const Text("Follow us on TikTok to earn 100 Sparks!", style: TextStyle(color: Colors.white70)),
      actions:[
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            bool claimed = prefs.getBool('social_claimed') ?? false;
            
            if (!claimed) {
              context.read<CurrencyManager>().addSparks(100);
              await prefs.setBool('social_claimed', true);
            }
            
            launchUrl(Uri.parse("https://tiktok.com"), mode: LaunchMode.externalApplication);
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text("Follow (+100 ⚡)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}