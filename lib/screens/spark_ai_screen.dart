import 'package:flutter/material.dart';

class SparkAIScreen extends StatelessWidget {
  const SparkAIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spark AI')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome, size: 64, color: Colors.deepPurpleAccent),
            SizedBox(height: 16),
            Text(
              'Spark AI Assistant',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Ask any question to start interactive learning.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
