import 'package:flutter/material.dart';
import '../services/currency_manager.dart';
import 'package:provider/provider.dart';

void checkDailyBonus(BuildContext context) {
  // Logic to check date stored in prefs
  // If new day:
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Daily Bonus!"),
      content: const Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.bolt, color: Colors.amber, size: 50),
        Text("+15 Sparks")
      ]),
      actions: [
        TextButton(
          onPressed: () {
            context.read<CurrencyManager>().addSparks(15);
            Navigator.pop(context);
          }, 
          child: const Text("Claim")
        )
      ],
    )
  );
}