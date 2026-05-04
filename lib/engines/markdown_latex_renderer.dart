import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart'; // Real LaTeX engine

class MarkdownLatexRenderer extends StatelessWidget {
  final String latexString;
  const MarkdownLatexRenderer({super.key, required this.latexString});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      child: Math.tex(
        latexString,
        textStyle: const TextStyle(fontSize: 20, color: Colors.cyanAccent),
        mathStyle: MathStyle.display,
      ),
    );
  }
}