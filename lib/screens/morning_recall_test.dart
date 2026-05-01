import 'package:flutter/material.dart';

class MorningRecallTest extends StatelessWidget {
  const MorningRecallTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.wb_sunny, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text("MORNING RECALL", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Before we start today, what was the answer to last night's final question?", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontSize: 18)),
            ),
            const TextField(decoration: InputDecoration(hintText: "Type answer...", filled: true, fillColor: Colors.white10)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Unlock Today's Lessons"))
          ],
        ),
      ),
    );
  }
}