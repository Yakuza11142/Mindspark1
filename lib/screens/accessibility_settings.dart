import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilitySettings extends StatefulWidget {
  const AccessibilitySettings({super.key});
  @override
  State<AccessibilitySettings> createState() => _AccessibilitySettingsState();
}

class _AccessibilitySettingsState extends State<AccessibilitySettings> {
  bool highContrast = false;
  double fontSize = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accessibility")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("High Contrast Mode"),
            value: highContrast,
            onChanged: (v) => setState(() => highContrast = v),
          ),
          ListTile(
            title: const Text("Font Scaling"),
            subtitle: Slider(
              value: fontSize, min: 0.8, max: 1.5,
              onChanged: (v) => setState(() => fontSize = v),
            ),
          )
        ],
      ),
    );
  }
}