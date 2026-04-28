import 'package:flutter/material.dart';
import '../data/supported_languages.dart';

class LanguageDropdown extends StatefulWidget {
  final Function(String) onSelect;
  const LanguageDropdown({super.key, required this.onSelect});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selected = "English";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.black87,
      value: selected,
      style: const TextStyle(color: Colors.cyanAccent),
      items: SupportedLanguages.list.map((l) => DropdownMenuItem(
        value: l.name,
        child: Text("${l.flag} ${l.name}"),
      )).toList(),
      onChanged: (val) {
        if (val != null) {
          setState(() => selected = val);
          widget.onSelect(val);
        }
      },
    );
  }
}