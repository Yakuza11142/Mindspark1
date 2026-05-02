import 'package:flutter/material.dart';

class IndependentStudentCelebration extends StatelessWidget {
  const IndependentStudentCelebration({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple[900],
      title: const Text("Happy 18th Birthday! 🎉", style: TextStyle(color: Colors.white)),
      content: const Text("You are now officially an independent adult. We have removed all parental tracking and emails. You are in full control of your destiny.", style: TextStyle(color: Colors.white70)),
      actions:[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("I'm Ready", style: TextStyle(color: Colors.cyanAccent)))
      ],
    );
  }
}