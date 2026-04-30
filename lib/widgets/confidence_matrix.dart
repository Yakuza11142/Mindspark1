import 'package:flutter/material.dart';

class ConfidenceMatrix extends StatelessWidget {
  const ConfidenceMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), border: Border.all(color: Colors.green)),
      child: Column(
        children: const[
          Icon(Icons.shield, color: Colors.greenAccent, size: 40),
          SizedBox(height: 10),
          Text("MASTERY CONFIRMED", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text("You have a 92% retention rate in (all the subjects). You are prepared.", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
        ],
      ),
    );
  }
}