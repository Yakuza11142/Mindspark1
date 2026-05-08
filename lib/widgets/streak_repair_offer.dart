import 'package:flutter/material.dart';

class StreakRepairOffer extends StatelessWidget {
  final VoidCallback onBuy;
  const StreakRepairOffer({super.key, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Streak Lost! 😭"),
      content: const Text("Pay 500 Sparks to repair it?"),
      actions: [ElevatedButton(onPressed: onBuy, child: const Text("Repair"))],
    );
  }
}