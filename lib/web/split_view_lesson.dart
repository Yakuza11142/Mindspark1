import 'package:flutter/material.dart';

class SplitViewLesson extends StatelessWidget {
  final Widget textContent;
  final Widget visualContent;

  const SplitViewLesson({super.key, required this.textContent, required this.visualContent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        // Left Side: AI Text
        Expanded(flex: 3, child: Container(padding: const EdgeInsets.all(40), child: textContent)),
        
        // Right Side: 3D AR or 4K Video
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              border: const Border(left: BorderSide(color: Colors.white10)),
              color: Colors.black,
            ),
            child: visualContent,
          ),
        ),
      ],
    );
  }
}