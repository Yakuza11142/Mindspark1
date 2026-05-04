import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OptimizedNetworkImage extends StatelessWidget {
  final String url;
  const OptimizedNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      memCacheWidth: 800, // Saves RAM by not loading full 4K into memory
      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.cyan)),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[900],
        child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
      ),
    );
  }
}