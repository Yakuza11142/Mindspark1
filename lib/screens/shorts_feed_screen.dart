import 'package:flutter/material.dart';
import '../widgets/short_video_card.dart';

class ShortsFeedScreen extends StatelessWidget {
  const ShortsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Vertical scrolling like TikTok
        itemCount: 10,
        itemBuilder: (ctx, i) {
          return ShortVideoCard(topic: "Science Fact #${i+1}");
        },
      ),
    );
  }
}