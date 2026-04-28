import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContextResetButton extends StatelessWidget {
  final VoidCallback onReset;
  const ContextResetButton({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh, color: Colors.redAccent),
      tooltip: "Clear AI Memory",
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('spark_chat_history'); // Clears the short-term memory
        onReset();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("AI Memory Wiped. Fresh Start.")));
      },
    );
  }
}