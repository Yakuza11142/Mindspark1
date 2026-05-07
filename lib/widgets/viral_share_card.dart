import 'package:flutter/material.dart';

class ViralShareCard extends StatelessWidget {
  final String topic;
  final int score;
  const ViralShareCard({super.key, required this.topic, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, height: 400,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors:[Colors.purple, Colors.blue]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          const Icon(Icons.bolt, size: 80, color: Colors.amber),
          const Text("MIND SPARK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 20),
          Text("I mastered $topic!", style: const TextStyle(fontSize: 20, color: Colors.white)),
          Text("Score: $score%", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
          const SizedBox(height: 20),
          const Text("Can you beat me? Download now.", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}