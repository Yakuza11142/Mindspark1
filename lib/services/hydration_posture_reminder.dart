import 'package:flutter/material.dart';

class HydrationPostureReminder {
  static void trigger(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.blueAccent,
      content: Text("💧 Drink a glass of water and sit up straight. Blood flow = Brain power."),
      duration: Duration(seconds: 4),
    ));
  }
}