import 'package:flutter/material.dart';

class LiquidRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  const LiquidRefresh({super.key, required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.cyanAccent,
      backgroundColor: Colors.black,
      child: child,
    );
  }
}