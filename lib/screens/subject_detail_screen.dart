import 'package:flutter/material.dart';
import 'lesson_screen.dart';

class SubjectDetailScreen extends StatelessWidget {
  final String subjectName;
  final Color color;
  const SubjectDetailScreen({super.key, required this.subjectName, required this.color});

  @override
  Widget build(BuildContext context) {
    // In production, fetch topics from an API or local list based on subjectName
    List<String> mockTopics =["Introduction to $subjectName", "Advanced Concepts", "Formulas & Equations", "Real World Applications"];

    return Scaffold(
      appBar: AppBar(title: Text(subjectName), backgroundColor: color.withOpacity(0.3)),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: mockTopics.length,
        itemBuilder: (ctx, i) => Card(
          color: Colors.white10,
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: color, child: Text("${i+1}", style: const TextStyle(color: Colors.white))),
            title: Text(mockTopics[i], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            trailing: const Icon(Icons.play_arrow, color: Colors.white),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(topic: "$subjectName: ${mockTopics[i]}", isPro: false, isPidgin: false))), // Pro handled by provider in real app
          ),
        ),
      ),
    );
  }
}