import 'package:flutter/material.dart';

class HoloDeckTriggerButton extends StatelessWidget {
  final bool isPro;
  final VoidCallback onTrigger;
  const HoloDeckTriggerButton({super.key, required this.isPro, required this.onTrigger});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: isPro ? Colors.purpleAccent : Colors.grey),
      icon: Icon(isPro ? Icons.view_in_ar : Icons.lock, color: Colors.white),
      label: Text(isPro ? "View in Holo-Deck" : "Pro 3D", style: const TextStyle(color: Colors.white)),
      onPressed: () {
        if (isPro) onTrigger();
        else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upgrade to Pro to generate 3D Models!")));
      },
    );
  }
}