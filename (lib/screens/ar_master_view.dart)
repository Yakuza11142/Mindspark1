import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import '../services/system_controller.dart';

class ARMasterView extends StatefulWidget {
  @override
  _ARMasterViewState createState() => _ARMasterViewState();
}

class _ARMasterViewState extends State<ARMasterView> {
  final SystemController _logic = SystemController();
  ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FRONTEND: The AR Camera View
          ArCoreView(
            onArCoreViewCreated: (controller) => arCoreController = controller,
            enableTapRecognizer: true,
          ),
          // FRONTEND UI: Educational Overlay
          Positioned(
            top: 50,
            left: 20,
            child: Text("MIND SPARK: LIVE DATA SYNC", style: TextStyle(color: Colors.cyanAccent)),
          ),
        ],
      ),
    );
  }

  // SIMULTANEOUS ACTION: When you tap, Backend & Frontend fire together
  void _onInteraction(String faceId) async {
    // 1. Backend: Check Database
    final user = await _logic.recognizeFace(faceId);
    
    // 2. Frontend: Update Hologram with name
    if (user != null) {
      print("System: Recognized ${user['name']}");
      // Code to update AR node goes here
    }
  }
}
