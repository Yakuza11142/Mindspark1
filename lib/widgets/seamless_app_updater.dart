import 'package:flutter/material.dart';

class SeamlessAppUpdater extends StatelessWidget {
  const SeamlessAppUpdater({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Downloading new AI modules in background...", style: TextStyle(color: Colors.cyanAccent, fontSize: 12)));
  }
}