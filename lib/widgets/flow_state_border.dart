import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlowStateBorder extends StatelessWidget {
  final Widget child;
  final bool isInFlow;

  const FlowStateBorder({super.key, required this.child, required this.isInFlow});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: isInFlow ?[BoxShadow(color: Colors.cyan.withOpacity(0.3), blurRadius: 30, spreadRadius: 10)] :[],
      ),
      child: child,
    ).animate(target: isInFlow ? 1 : 0).shimmer(duration: 2000.ms, color: Colors.cyanAccent);
  }
}