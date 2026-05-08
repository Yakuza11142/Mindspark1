import 'package:flutter/material.dart';
import '../engines/grammar_explainer_engine.dart';

class GrammarPopup extends StatelessWidget {
  final String sentence, mistake;
  const GrammarPopup({super.key, required this.sentence, required this.mistake});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: GrammarExplainerEngine.explainRule(sentence, mistake),
      builder: (ctx, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Icon(Icons.menu_book, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(snap.data!, style: const TextStyle(color: Colors.white)))
            ],
          ),
        );
      },
    );
  }
}