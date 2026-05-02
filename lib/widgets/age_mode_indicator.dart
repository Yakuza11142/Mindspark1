import 'package:flutter/material.dart';

class AgeModeIndicator extends StatelessWidget {
  final String lifeStage;
  const AgeModeIndicator({super.key, required this.lifeStage});

  @override
  Widget build(BuildContext context) {
    Color c = lifeStage == "JUNIOR" ? Colors.green : lifeStage == "SCHOLAR" ? Colors.cyan : Colors.purple;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: c.withOpacity(0.2), border: Border.all(color: c), borderRadius: BorderRadius.circular(5)),
      child: Text("$lifeStage MODE", style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}