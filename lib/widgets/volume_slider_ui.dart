import 'package:flutter/material.dart';
import '../services/audio_volume_controller.dart';

class VolumeSliderUi extends StatefulWidget {
  const VolumeSliderUi({super.key});
  @override
  State<VolumeSliderUi> createState() => _VolumeSliderUiState();
}

class _VolumeSliderUiState extends State<VolumeSliderUi> {
  double vol = 1.0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        const Icon(Icons.volume_down, color: Colors.white),
        Expanded(
          child: Slider(
            value: vol, min: 0.0, max: 1.0, activeColor: Colors.cyanAccent,
            onChanged: (v) { setState(() => vol = v); AudioVolumeController.setVolume(v); }
          ),
        ),
      ],
    );
  }
}