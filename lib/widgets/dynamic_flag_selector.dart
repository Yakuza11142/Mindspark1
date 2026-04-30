import 'package:flutter/material.dart';

class DynamicFlagSelector extends StatelessWidget {
  final String currentCountry;
  final Function(String) onSelect;
  const DynamicFlagSelector({super.key, required this.currentCountry, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentCountry,
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      items: const[
        DropdownMenuItem(value: 'NG', child: Text("🇳🇬 Nigeria (JAMB)")),
        DropdownMenuItem(value: 'US', child: Text("🇺🇸 USA (SAT)")),
        DropdownMenuItem(value: 'GB', child: Text("🇬🇧 UK (GCSE)")),
      ],
      onChanged: (v) => onSelect(v!),
    );
  }
}