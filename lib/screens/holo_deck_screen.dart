import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class HoloDeckScreen extends StatefulWidget {
  final String topic;
  const HoloDeckScreen({super.key, required this.topic});

  @override
  State<HoloDeckScreen> createState() => _HoloDeckScreenState();
}

class _HoloDeckScreenState extends State<HoloDeckScreen> {
  bool isStadiumMode = false; // False = Desk size. True = Stadium size.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Holo-Deck"),
        actions: [
          Row(
            children:[
              const Text("STADIUM MODE", style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold)),
              Switch(
                value: isStadiumMode,
                activeColor: Colors.amber,
                onChanged: (v) => setState(() => isStadiumMode = v),
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children:[
          ModelViewer(
            src: "https://models.tripo.ai/dynamic_model.glb", // Tripo AI URL
            ar: true,
            arPlacement: ArPlacement.floor,
            arScale: isStadiumMode ? ArScale.fixed : ArScale.auto, // THE MAGIC TOGGLE
            autoRotate: true,
            cameraControls: true,
            backgroundColor: Colors.transparent,
          ),
          const Positioned(
            bottom: 40, left: 0, right: 0,
            child: Text("Point camera at the floor. Tap screen to place hologram.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white54)),
          )
        ],
      ),
    );
  }
}