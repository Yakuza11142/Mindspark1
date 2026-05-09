import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VoiceModeScreen extends StatelessWidget {
  const VoiceModeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundColor: Colors.cyanAccent,
              child: Icon(Icons.mic, size: 50, color: Colors.black),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.2,1.2)),
            const SizedBox(height: 40),
            const Text("Listening...", style: TextStyle(fontSize: 24, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}