import 'package:flutter/material.dart';

class RegionSelectorDropdown extends StatelessWidget {
  final Function(String) onSelect;
  const RegionSelectorDropdown({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      value: "NG", // Default
      items: const[
        DropdownMenuItem(value: "NG", child: Text("Nigeria (JAMB/WAEC)")),
        DropdownMenuItem(value: "US", child: Text("United States (SAT)")),
        DropdownMenuItem(value: "IN", child: Text("India (JEE/NEET)")),
        DropdownMenuItem(value: "GB", child: Text("UK (GCSE)")),
      ],
      onChanged: (v) => onSelect(v!),
    );
  }
}