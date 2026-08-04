import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HapticKeyboardWrapper extends StatelessWidget {
  final Widget child;
  final bool isEnabled; 

  const HapticKeyboardWrapper({
    super.key, 
    required this.child, 
    this.isEnabled = true, 
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus && isEnabled) {
          HapticFeedback.lightImpact();
        }
      },
      child: child,
    );
  }
}

class SettingsHapticsTile extends StatelessWidget {
  final bool hapticEnabled;
  final ValueChanged<bool> onChanged;

  const SettingsHapticsTile({
    super.key,
    required this.hapticEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Keyboard Haptics"),
      value: hapticEnabled,
      onChanged: onChanged,
    );
  }
}
