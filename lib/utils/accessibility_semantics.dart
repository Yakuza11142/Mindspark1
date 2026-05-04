import 'package:flutter/material.dart';

class AccessibilitySemantics extends StatelessWidget {
  final Widget child;
  final String label;
  final String hint;

  const AccessibilitySemantics({super.key, required this.child, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      button: true,
      child: child,
    );
  }
}