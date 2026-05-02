import 'package:flutter/material.dart';

class BrainDumpScreen extends StatelessWidget {
  const BrainDumpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Active Recall")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Text("Without looking at your notes, type everything you just learned.", style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 20),
            const Expanded(child: TextField(maxLines: null, expands: true, decoration: InputDecoration(hintText: "Start typing...", border: OutlineInputBorder()))),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("FINISH & SAVE MEMORY"))
          ],
        ),
      ),
    );
  }
}