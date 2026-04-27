import 'package:flutter/material.dart';

class TopicSuggestion extends StatelessWidget {
  final Function(String) onSelect;
  const TopicSuggestion({super.key, required this.onSelect});

  final List<String> topics = const ["Black Holes", "Photosynthesis", "WW2", "Python Code", "Calculus"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: topics.map((t) => ActionChip(
        label: Text(t),
        onPressed: () => onSelect(t),
        backgroundColor: Colors.white10,
      )).toList(),
    );
  }
}