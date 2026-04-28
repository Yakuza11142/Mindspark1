import 'package:flutter/material.dart';

class HologramLoadingMatrix extends StatelessWidget {
  const HologramLoadingMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
        CircularProgressIndicator(color: Colors.purpleAccent),
        SizedBox(height: 20),
        Text("Materializing Full-Body Avatar...", style: TextStyle(color: Colors.cyanAccent, fontFamily: 'monospace')),
        Text("Syncing Inverse Kinematics...", style: TextStyle(color: Colors.white54, fontSize: 10)),
      ],
    );
  }
}