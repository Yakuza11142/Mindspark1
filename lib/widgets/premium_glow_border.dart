import 'package:flutter/material.dart';

class PremiumGlowBorder extends StatelessWidget {
  final Widget child;
  const PremiumGlowBorder({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow:[BoxShadow(color: Colors.cyanAccent.withOpacity(0.3), blurRadius: 15)],
        border: Border.all(color: Colors.cyanAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}