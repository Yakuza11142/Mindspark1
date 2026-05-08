import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitationCard extends StatelessWidget {
  final String text;
  const CitationCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white10,
      child: Row(
        children: [
          Expanded(child: Text(text, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white))),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.cyan),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copied!")));
            },
          )
        ],
      ),
    );
  }
}