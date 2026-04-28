import 'package:flutter/material.dart';
import '../screens/holo_deck_screen.dart';
import '../screens/paywall_screen.dart';

class HoloDeckProGate extends StatelessWidget {
  final bool isPro;
  final String topic;
  const HoloDeckProGate({super.key, required this.isPro, required this.topic});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: isPro ? Colors.purpleAccent : Colors.grey[800]),
      icon: Icon(isPro ? Icons.view_in_ar : Icons.lock, color: Colors.white),
      label: const Text("🔮 PRO HOLOGRAM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      onPressed: () {
        if (isPro) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HoloDeckScreen(topic: topic)));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
        }
      },
    );
  }
}