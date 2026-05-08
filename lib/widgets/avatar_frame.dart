import 'package:flutter/material.dart';

class AvatarFrame extends StatelessWidget {
  final Widget child;
  final bool isPro;
  const AvatarFrame({super.key, required this.child, required this.isPro});

  @override
  Widget build(BuildContext context) {
    if (!isPro) return child;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.amber, width: 3),
        boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 10)]
      ),
      child: child,
    );
  }
}