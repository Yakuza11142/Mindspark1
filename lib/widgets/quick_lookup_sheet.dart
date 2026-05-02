import 'package:flutter/material.dart';
import '../services/local_dictionary_cache.dart';

class QuickLookupSheet extends StatelessWidget {
  final String selectedWord;
  const QuickLookupSheet({super.key, required this.selectedWord});

  @override
  Widget build(BuildContext context) {
    String definition = LocalDictionaryCache.lookup(selectedWord);

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blueGrey[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(selectedWord.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(definition, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Got it"))
        ],
      ),
    );
  }
}