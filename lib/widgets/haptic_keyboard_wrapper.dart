import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HapticKeyboardWrapper extends StatelessWidget {
  final Widget child;
  const HapticKeyboardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) HapticFeedback.lightImpact();
      },
      child: child,
    );
  }
}