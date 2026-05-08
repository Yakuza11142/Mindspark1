import 'package:flutter/material.dart';

class ParallaxListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  
  const ParallaxListItem({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    // Simplified parallax logic using Flow or Stack
    return Container(
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15)
      ),
      alignment: Alignment.center,
      child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, backgroundColor: Colors.black45)),
    );
  }
}