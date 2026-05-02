import 'package:flutter/material.dart';

class AiToneSelector extends StatefulWidget {
  final Function(String) onToneSelected;
  const AiToneSelector({super.key, required this.onToneSelected});

  @override
  State<AiToneSelector> createState() => _AiToneSelectorState();
}

class _AiToneSelectorState extends State<AiToneSelector> {
  String _selected = "Academic";
  final List<String> _tones =["Academic", "Friendly", "Strict Coach", "Naija Uncle"];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selected,
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.cyanAccent),
      items: _tones.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
      onChanged: (val) {
        if (val != null) {
          setState(() => _selected = val);
          widget.onToneSelected(val);
        }
      },
    );
  }
}