import 'package:flutter/material.dart';
class ProBadge extends StatelessWidget {
  const ProBadge({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(5)),
      child: const Text("PRO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
    );
  }
}