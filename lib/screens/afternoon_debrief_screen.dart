import 'package:flutter/material.dart';

class AfternoonDebriefScreen extends StatelessWidget {
  const AfternoonDebriefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.wb_twilight, size: 80, color: Colors.orangeAccent),
            const SizedBox(height: 20),
            const Text("School's Out.", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("You survived the day. Let's do 10 quick offline Flashcards on the ride home before you rest.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Start 5-Min Review"))
          ],
        ),
      ),
    );
  }
}