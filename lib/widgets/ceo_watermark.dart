import 'package:flutter/material.dart';

class CeoWatermark extends StatelessWidget {
  const CeoWatermark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "MIND SPARK v1.0",
        style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold),
      ),
    );
  }
}