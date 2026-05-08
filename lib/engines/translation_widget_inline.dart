import 'package:flutter/material.dart';
import '../engines/translation_engine.dart'; // Script 501

class TranslationPopup extends StatelessWidget {
  final String word;
  const TranslationPopup({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: TranslationEngine.translate(word, "French"), // Default to French for now
      builder: (ctx, snap) => AlertDialog(
        title: Text("Translate: $word"),
        content: Text(snap.data ?? "Loading..."),
      ),
    );
  }
}