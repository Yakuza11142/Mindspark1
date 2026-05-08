import 'package:flutter/material.dart';
import '../engines/summarizer_engine.dart';

class SummaryButton extends StatelessWidget {
  final String text;
  const SummaryButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.short_text),
      onPressed: () async {
        String summary = await SummarizerEngine.summarize(text);
        showDialog(context: context, builder: (_) => AlertDialog(content: Text(summary)));
      },
    );
  }
}