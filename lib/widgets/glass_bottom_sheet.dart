import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBottomSheet extends StatelessWidget {
  final Widget child;
  const GlassBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), border: const Border(top: BorderSide(color: Colors.white24))),
          child: child,
        ),
      ),
    );
  }
}