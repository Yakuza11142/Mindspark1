import 'package:flutter/material.dart';
import '../engines/topic_expansion_engine.dart';
import 'lesson_screen.dart';

class SubtopicSelectionScreen extends StatelessWidget {
  final String mainTopic;
  const SubtopicSelectionScreen({super.key, required this.mainTopic});

  @override
  Widget build(BuildContext context) {
    List<String> subtopics = TopicExpansionEngine.getSubtopics(mainTopic);

    return Scaffold(
      appBar: AppBar(title: Text(mainTopic)),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: subtopics.length,
        itemBuilder: (ctx, i) => Card(
          color: Colors.white10,
          child: ListTile(
            title: Text(subtopics[i], style: const TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.cyan, size: 16),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(topic: "$mainTopic: ${subtopics[i]}", isPro: false))),
          ),
        ),
      ),
    );
  }
}