import 'package:flutter/material.dart';

class CeoStealthToast {
  static void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🛡️ COMMAND CENTER UNLOCKED. WELCOME, CEO.", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1)),
        backgroundColor: Colors.cyanAccent,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      )
    );
  }
}