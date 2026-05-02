import 'package:flutter/material.dart';

class JambOnScreenKeyboard extends StatelessWidget {
  final Function(String) onKeyPress;
  const JambOnScreenKeyboard({super.key, required this.onKeyPress});

  @override
  Widget build(BuildContext context) {
    List<String> keys =['A', 'B', 'C', 'D', 'P', 'N', 'S', 'R']; // P=Prev, N=Next, S=Submit, R=Reverse
    return Wrap(
      spacing: 10, runSpacing: 10,
      alignment: WrapAlignment.center,
      children: keys.map((k) => ElevatedButton(
        onPressed: () => onKeyPress(k),
        style: ElevatedButton.styleFrom(minimumSize: const Size(60, 60)),
        child: Text(k, style: const TextStyle(fontSize: 20)),
      )).toList(),
    );
  }
}