import 'package:flutter/material.dart';
import '../services/currency_manager.dart';

class DailyRewardPopup extends StatelessWidget {
  const DailyRewardPopup({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Daily Login"),
      content: const Text("Here is 20 Sparks!"),
      actions: [
        TextButton(onPressed: () {
          CurrencyManager().addSparks(20);
          Navigator.pop(context);
        }, child: const Text("CLAIM"))
      ],
    );
  }
}