import 'package:flutter/material.dart';

class MemoryPalaceScreen extends StatelessWidget {
  const MemoryPalaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(color: Colors.black), // Camera feed goes here
          const Center(child: Icon(Icons.add_circle_outline, color: Colors.cyan, size: 50)),
          const Positioned(bottom: 50, left: 20, right: 20, child: Text("Scan your room. Tap the + to pin a physics formula to your wall.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))),
        ],
      ),
    );
  }
}