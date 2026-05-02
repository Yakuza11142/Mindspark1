import 'package:flutter/material.dart';

class OfflineToast extends StatelessWidget {
  const OfflineToast({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(20)),
      child: const Text("Working Offline ⚡", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
    );
  }
}