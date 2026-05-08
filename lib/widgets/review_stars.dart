import 'package:flutter/material.dart';

class ReviewStars extends StatefulWidget {
  final Function(int) onRate;
  const ReviewStars({super.key, required this.onRate});
  @override
  State<ReviewStars> createState() => _ReviewStarsState();
}

class _ReviewStarsState extends State<ReviewStars> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) => IconButton(
        icon: Icon(i < rating ? Icons.star : Icons.star_border, color: Colors.amber),
        onPressed: () {
          setState(() => rating = i + 1);
          widget.onRate(rating);
        },
      )),
    );
  }
}