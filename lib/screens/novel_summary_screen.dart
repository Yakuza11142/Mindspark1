import 'package:flutter/material.dart';

class NovelSummaryScreen extends StatelessWidget {
  final String novelTitle;
  final Map<String, String> chapters; // Key: Chapter Name, Value: Summary text

  const NovelSummaryScreen({
    super.key,
    required this.novelTitle,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(novelTitle, style: const TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (ctx, i) {
          String chapterKey = chapters.keys.elementAt(i);
          String summaryValue = chapters.values.elementAt(i);
          
          return ExpansionTile(
            iconColor: Colors.cyan,
            collapsedIconColor: Colors.cyan,
            title: Text(
              chapterKey, 
              style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0), 
                child: Text(
                  summaryValue, 
                  style: const TextStyle(color: Colors.white, height: 1.5)
                )
              )
            ],
          );
        },
      ),
    );
  }
}
