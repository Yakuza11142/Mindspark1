import 'package:flutter/material.dart';
import '../widgets/holo_deck_viewer.dart';

class StagePresentationArScreen extends StatelessWidget {
  const StagePresentationArScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For your stage demo, you don't want to rely on the internet to generate a 3D model.
    // You use a PRE-DOWNLOADED, hyper-detailed 3D model saved in your assets folder.
    // Example: A massive, highly detailed Human Heart or an Apollo Rocket.
    const String demoModelUrl = "assets/models/human_heart_stage_demo.glb";

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children:[
          // THE HOLO-DECK
          const HoloDeckViewer(
            modelUrl: demoModelUrl,
            topic: "Human Anatomy - Masterclass",
          ),

          // THE STAGE BRANDING (Visible on the projector)
          Positioned(
            top: 50, 
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const[
                Text("MINDSPARK ELITE", style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 3)),
                Text("LIVE DEMONSTRATION", style: TextStyle(color: Colors.redAccent, fontSize: 14, letterSpacing: 5)),
              ],
            ),
          ),
          
          // EXIT BUTTON
          Positioned(
            top: 50, right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}