// Add flutter_tex to pubspec
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class MathParser extends StatelessWidget {
  final String latex;
  const MathParser({super.key, required this.latex});

  @override
  Widget build(BuildContext context) {
    return TeXView(
      child: TeXViewDocument(latex),
      style: const TeXViewStyle(contentColor: Colors.white),
    );
  }
}