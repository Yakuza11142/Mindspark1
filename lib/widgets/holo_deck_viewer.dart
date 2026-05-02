import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../engines/ar_environment_config.dart';
import 'dart:ui';

class HoloDeckViewer extends StatefulWidget {
  final String modelUrl; // The Tripo AI 3D Model URL
  final String topic;

  const HoloDeckViewer({super.key, required this.modelUrl, required this.topic});

  @override
  State<HoloDeckViewer> createState() => _HoloDeckViewerState();
}

class _HoloDeckViewerState extends State<HoloDeckViewer> {
  // THE GOD-MODE SWITCH: False = Desk Size, True = Stadium Size
  bool _isStadiumScale = false; 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        // =====================================================================
        // THE GOOGLE ARCORE ENGINE
        // =====================================================================
        ModelViewer(
          src: widget.modelUrl,
          alt: "MindSpark 3D Hologram of ${widget.topic}",
          
          // 1. TURN ON THE CAMERA & AR SENSORS
          ar: true, 
          
          // 2. WHERE TO PUT IT (Floor is best for stadiums)
          arPlacement: ArPlacement.floor, 
          
          // 3. THE SIZE CONTROL (Auto = Fits on Screen. Fixed = True Real-World Size)
          arScale: _isStadiumScale ? ArScale.fixed : ArScale.auto, 
          
          // 4. THE REALISM (Lighting and Shadows)
          environmentImage: ArEnvironmentConfig.getRealisticLighting(),
          shadowIntensity: 1.5,
          
          // 5. ENGINE ROUTING
          arModes: ['scene-viewer', 'webxr', 'quick-look'],

          // 6. UX CONTROLS
          autoRotate: true,
          cameraControls: true,
          backgroundColor: Colors.transparent, // Crucial: Lets the camera show through
        ),

        // =====================================================================
        // THE UI OVERLAY: STADIUM MODE TOGGLE
        // =====================================================================
        Positioned(
          bottom: 40, 
          left: 20, 
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  border: Border.all(color: _isStadiumScale ? Colors.redAccent : Colors.cyanAccent),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          _isStadiumScale ? "STADIUM SCALE: 1:1" : "DESK SCALE: AUTO",
                          style: TextStyle(
                            color: _isStadiumScale ? Colors.redAccent : Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const Text("Tap 'View in your space' to project", style: TextStyle(color: Colors.white70, fontSize: 10)),
                      ],
                    ),
                    Switch(
                      value: _isStadiumScale,
                      activeColor: Colors.redAccent,
                      inactiveThumbColor: Colors.cyanAccent,
                      onChanged: (val) {
                        setState(() {
                          _isStadiumScale = val;
                        });
                        // Haptic feedback to feel the power shift
                        // HapticFeedback.heavyImpact(); 
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}