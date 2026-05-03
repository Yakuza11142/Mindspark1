import 'package:flutter/material.dart';

class DataSaverToggle extends StatelessWidget {
  const DataSaverToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Data Saver Mode"),
      subtitle: const Text("Disables 4K Video and 3D to save data."),
      value: false, // Map to SharedPreferences in prod
      onChanged: (v) {},
    );
  }
}