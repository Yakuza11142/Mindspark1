import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LowRamModeToggle extends StatefulWidget {
  const LowRamModeToggle({super.key});
  @override
  State<LowRamModeToggle> createState() => _LowRamModeToggleState();
}

class _LowRamModeToggleState extends State<LowRamModeToggle> {
  bool isLowRam = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Low RAM Mode (Fast)"),
      subtitle: const Text("Turns off moving backgrounds"),
      activeColor: Colors.amber,
      value: isLowRam,
      onChanged: (v) async {
        setState(() => isLowRam = v);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('low_ram_mode', v);
      },
    );
  }
}