import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARHologramScreen extends StatefulWidget {
  @override
  _ARHologramScreenState createState() => _ARHologramScreenState();
}

class _ARHologramScreenState extends State<ARHologramScreen> {
  ArCoreController? arCoreController;

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    // Add the "Hologram" automatically in front of the user
    _addHologram(arCoreController!);
  }

  void _addHologram(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.greenAccent.withOpacity(0.6),
      metallic: 1.0,
    );

    // Create a 3D Shape (The Hologram Core)
    final cylinder = ArCoreCylinder(
      materials: [material],
      radius: 0.1,
      height: 0.05,
    );

    final node = ArCoreNode(
      shape: cylinder,
      position: vector.Vector3(0, 0, -1.5), // Projects 1.5 meters in front of you
      rotation: vector.Vector4(1, 0, 0, 1), 
      // This is where the interaction happens
      name: "Hologram_Shield", 
    );

    controller.addArCoreNode(node);
    
    // Listen for taps on the hologram
    controller.onNodeTap = (name) {
      if (name == "Hologram_Shield") {
        _showInteractionDialog();
      }
    };
  }

  void _showInteractionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text("SYSTEM ACCESS", style: TextStyle(color: Colors.greenAccent)),
        content: Text("Hologram interaction detected. Subject: PHYSICS."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AR Hologram Projector")),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
