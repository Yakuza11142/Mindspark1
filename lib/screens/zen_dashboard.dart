import 'package:flutter/material.dart';

class ZenDashboard extends StatelessWidget {
  const ZenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(title: const Text("MindSpark Zen", style: TextStyle(color: Colors.white38)), backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.self_improvement, size: 80, color: Colors.cyan),
            const SizedBox(height: 20),
            const Text("Your mind is ready.", style: TextStyle(fontSize: 24, color: Colors.white)),
            const Text("Select a topic to review peacefully.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            // Custom relaxed search bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(30)),
              child: const TextField(decoration: InputDecoration(hintText: "Enter topic...", border: InputBorder.none, icon: Icon(Icons.search, color: Colors.cyan))),
            )
          ],
        ),
      ),
    );
  }
}