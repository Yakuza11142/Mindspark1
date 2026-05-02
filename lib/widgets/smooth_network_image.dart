import 'package:flutter/material.dart';

class SmoothNetworkImage extends StatelessWidget {
  final String url;
  const SmoothNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator(color: Colors.cyanAccent));
      },
      errorBuilder: (ctx, err, stack) => Container(color: Colors.grey[900], child: const Icon(Icons.broken_image)),
    );
  }
}