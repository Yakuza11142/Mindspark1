import 'package:flutter/material.dart';

class WarningSnackBar {
  static void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Language warning recorded. Please maintain academic focus.", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      )
    );
  }
}