import 'package:flutter/material.dart';
import 'main_layout_screen.dart';

class FounderWelcomeScreen extends StatelessWidget {
  const FounderWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Icon(Icons.auto_awesome, color: Colors.amber, size: 60),
            const SizedBox(height: 20),
            const Text("Welcome to the Future.", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
              "I built Mind Spark because the old way of learning is broken. Here, you don't just read. You experience. Use the Holo-Deck. Ask the AI. Crush your exams.",
              style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
            ),
            const SizedBox(height: 40),
            const Text("- The Founder", style: TextStyle(color: Colors.cyanAccent, fontStyle: FontStyle.italic)),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 50)),
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayoutScreen())),
              child: const Text("ENTER MINDSPARK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}