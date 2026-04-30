import 'package:flutter/material.dart';

class KnowledgeGraphScreen extends StatelessWidget {
  const KnowledgeGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Knowledge Graph")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.share, size: 80, color: Colors.cyan), // Placeholder for graph rendering
            const SizedBox(height: 20),
            const Text("Concept Mapping", style: TextStyle(fontSize: 24, color: Colors.white)),
            const Text("See how physics connects to chemistry.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}