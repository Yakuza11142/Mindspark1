import 'package:flutter/material.dart';

class GameLivesWidget extends StatelessWidget {
  final int lives;
  const GameLivesWidget({super.key, required this.lives});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < lives ? Icons.favorite : Icons.favorite_border,
          color: Colors.redAccent,
          size: 24,
        );
      }),
    );
  }
}