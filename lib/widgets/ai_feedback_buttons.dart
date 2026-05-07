import 'package:flutter/material.dart';

class AiFeedbackButtons extends StatelessWidget {
  const AiFeedbackButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:[
        IconButton(icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey, size: 18), onPressed: (){}),
        IconButton(icon: const Icon(Icons.thumb_down_alt_outlined, color: Colors.grey, size: 18), onPressed: (){}),
      ],
    );
  }
}