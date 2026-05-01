import 'package:flutter/material.dart';

class ConfidenceSelector extends StatelessWidget {
  final Function(String) onSelect;
  const ConfidenceSelector({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        TextButton(onPressed: () => onSelect("Guessed"), child: const Text("I Guessed 🎲", style: TextStyle(color: Colors.orange))),
        TextButton(onPressed: () => onSelect("Not Sure"), child: const Text("Not Sure 🤔", style: TextStyle(color: Colors.yellow))),
        TextButton(onPressed: () => onSelect("100% Sure"), child: const Text("100% Sure 🔥", style: TextStyle(color: Colors.greenAccent))),
      ],
    );
  }
}