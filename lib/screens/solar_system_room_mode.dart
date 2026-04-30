import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../engines/room_scale_ar_mapper.dart';

class SolarSystemRoomMode extends StatelessWidget {
  const SolarSystemRoomMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children:[
          ModelViewer(
            src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // Your dynamic Tripo URL here
            ar: true,
            arPlacement: ArPlacement.floor,
            autoRotate: true,
            cameraControls: true,
            // Injects the Room-Scale parameters
            relatedCss: RoomScaleArMapper.configureRoomScale(),
          ),
          const Positioned(
            top: 50, left: 20,
            child: Text("ROOM-SCALE AR ACTIVE", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
          )
        ],
      ),
    );
  }
}