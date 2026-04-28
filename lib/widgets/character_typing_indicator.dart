import 'package:flutter/material.dart';

class CharacterTypingIndicator extends StatelessWidget {
  final Color themeColor;
  const CharacterTypingIndicator({super.key, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Processing matrix...", style: TextStyle(color: themeColor, fontStyle: FontStyle.italic, fontSize: 12)),
    );
  }
}