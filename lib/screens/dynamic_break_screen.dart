import 'package:flutter/material.dart';

class DynamicBreakScreen extends StatelessWidget {
  final String lifeStage;
  const DynamicBreakScreen({super.key, required this.lifeStage});

  @override
  Widget build(BuildContext context) {
    String msg = lifeStage == "JUNIOR" 
      ? "Time to stretch! Go drink some water! 💧" 
      : "Cognitive limit reached. Step away from the screen for 5 minutes.";

    return Container(
      color: Colors.black87,
      child: Center(child: Text(msg, style: const TextStyle(color: Colors.cyanAccent, fontSize: 20), textAlign: TextAlign.center)),
    );
  }
}