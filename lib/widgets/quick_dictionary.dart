import 'package:flutter/material.dart';
import '../engines/dictionary_engine.dart';

class QuickDictionary extends StatefulWidget {
  const QuickDictionary({super.key});
  @override
  State<QuickDictionary> createState() => _QuickDictionaryState();
}

class _QuickDictionaryState extends State<QuickDictionary> {
  final TextEditingController _ctrl = TextEditingController();
  String _def = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Quick Dictionary"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _ctrl,
            decoration: const InputDecoration(hintText: "Enter word"),
            onSubmitted: (val) async {
              String d = await DictionaryEngine.define(val);
              setState(() => _def = d);
            },
          ),
          const SizedBox(height: 10),
          Text(_def)
        ],
      ),
    );
  }
}