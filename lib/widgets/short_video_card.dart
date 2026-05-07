import 'package:flutter/material.dart';
import '../engines/shorts_generator.dart';

class ShortVideoCard extends StatefulWidget {
  final String topic;
  const ShortVideoCard({super.key, required this.topic});

  @override
  State<ShortVideoCard> createState() => _ShortVideoCardState();
}

class _ShortVideoCardState extends State<ShortVideoCard> {
  String fact = "Loading...";

  @override
  void initState() {
    super.initState();
    ShortsGenerator.getQuickFact("Space").then((val) => setState(() => fact = val));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.blueGrey[900]), // In prod, put Pexels video player here
        Positioned(
          bottom: 100, left: 20, right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(widget.topic, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.cyan)),
              const SizedBox(height: 10),
              Text(fact, style: const TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
        Positioned(
          bottom: 100, right: 20,
          child: Column(
            children:[
              IconButton(icon: const Icon(Icons.favorite, color: Colors.white, size: 40), onPressed: (){}),
              const SizedBox(height: 20),
              IconButton(icon: const Icon(Icons.share, color: Colors.white, size: 40), onPressed: (){}),
            ],
          ),
        )
      ],
    );
  }
}