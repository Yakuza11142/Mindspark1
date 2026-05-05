import 'package:flutter/material.dart';

class TtsSttControlBar extends StatelessWidget {
  final String textToRead;
  final bool isPro;
  const TtsSttControlBar({super.key, required this.textToRead, required this.isPro});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        IconButton(
          icon: Icon(isPro ? Icons.volume_up : Icons.lock_outline, color: Colors.cyanAccent),
          onPressed: () {
            if (isPro) {
              // Trigger ElevenLabs
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Playing Studio Audio...")));
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.mic, color: Colors.amber),
          onPressed: () {
            // Trigger Speech-to-Text
          },
        )
      ],
    );
  }
}