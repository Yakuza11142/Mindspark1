import 'package:flutter/material.dart';

class PetHealthBar extends StatelessWidget {
  final double healthPct;
  const PetHealthBar({super.key, required this.healthPct});
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: healthPct,
      backgroundColor: Colors.red[900],
      color: Colors.greenAccent,
      minHeight: 20,
    );
  }
}