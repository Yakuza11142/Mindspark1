import 'package:flutter/material.dart';

class MasteryDashboard extends StatelessWidget {
  const MasteryDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.psychology, size: 100, color: Colors.cyanAccent),
            const SizedBox(height: 20),
            const Text("ENTER THE FLOW STATE", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 3)),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text("Distractions are muted. Background noise is blocked. Focus entirely on the concept in front of you. You are ready to master this.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
              onPressed: () {}, // Begin lesson
              child: const Text("BEGIN DEEP WORK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}