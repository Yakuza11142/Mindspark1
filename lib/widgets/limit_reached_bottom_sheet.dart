import 'package:flutter/material.dart';
import '../screens/watch_to_unlock_screen.dart';
import '../screens/paywall_screen.dart';

class LimitReachedBottomSheet extends StatelessWidget {
  const LimitReachedBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => const LimitReachedBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          const Icon(Icons.battery_alert, size: 60, color: Colors.orange),
          const SizedBox(height: 20),
          const Text("Daily Limit Reached", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("You've used your 15 free questions for today. Upgrade to Pro or watch ads to continue learning.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WatchToUnlockScreen())),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900], minimumSize: const Size(double.infinity, 50)),
            child: const Text("WATCH 3 ADS (FREE PRO)", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PaywallScreen())),
            child: const Text("SUBSCRIBE (₦4,500/mo)", style: TextStyle(color: Colors.cyanAccent)),
          )
        ],
      ),
    );
  }
}