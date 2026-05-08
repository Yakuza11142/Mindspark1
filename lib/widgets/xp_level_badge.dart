import 'package:flutter/material.dart';

class XpLevelBadge extends StatelessWidget {
  final int level;
  const XpLevelBadge({super.key, required this.level});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.amber,
      child: Text("$level", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}