import 'package:flutter/material.dart';

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  const FadeIndexedStack({super.key, required this.index, required this.children});
  @override
  State<FadeIndexedStack> createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      children: widget.children.map((child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: child,
      )).toList(),
    );
  }
}