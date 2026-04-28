import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../engines/avatar_animation_sync.dart';

class ArCharacterRenderer extends StatelessWidget {
  final String glbUrl;
  final bool isSpeaking;
  final String idleAnim;
  final String talkAnim;

  const ArCharacterRenderer({super.key, required this.glbUrl, required this.isSpeaking, required this.idleAnim, required this.talkAnim});

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: glbUrl,
      ar: true,
      arPlacement: ArPlacement.floor,
      arScale: ArScale.fixed, // FORCES LIFE-SIZE (2.0 meters tall)
      autoAnimate: true,
      animationName: AvatarAnimationSync.syncWithAudio(isSpeaking, idleAnim, talkAnim),
      cameraControls: true,
      backgroundColor: Colors.transparent,
    );
  }
}