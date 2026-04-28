import 'package:flutter/material.dart';
import '../engines/dalle_image_engine.dart'; // From previous scripts

class Dynamic2dFallbackRenderer extends StatelessWidget {
  final String topic;
  const Dynamic2dFallbackRenderer({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: DalleImageEngine.generate(topic),
      builder: (ctx, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return Image.network(snap.data!, fit: BoxFit.cover);
      },
    );
  }
}