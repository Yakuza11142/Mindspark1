import 'package:flutter/material.dart';

class ConfidenceBoosterUi extends StatelessWidget {
  final int totalQuestionsPassed;
  const ConfidenceBoosterUi({super.key, required this.totalQuestionsPassed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[900],
      padding: const EdgeInsets.all(20),
      child: Column(
        children:[
          const Icon(Icons.shield, color: Colors.greenAccent, size: 60),
          const Text("YOU ARE READY.", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text("You have correctly answered $totalQuestionsPassed questions this month.", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}