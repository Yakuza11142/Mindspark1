import 'package:flutter/material.dart';
// Add flutter_highlight to pubspec
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';

class CodeEditorWidget extends StatelessWidget {
  final String code;
  final String language;

  const CodeEditorWidget({super.key, required this.code, required this.language});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF282A36),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language.toUpperCase(), style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
              const Icon(Icons.copy, color: Colors.white54, size: 16)
            ],
          ),
          const Divider(color: Colors.white24),
          HighlightView(
            code,
            language: language,
            theme: draculaTheme,
            padding: const EdgeInsets.all(8),
            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 14),
          ),
        ],
      ),
    );
  }
}