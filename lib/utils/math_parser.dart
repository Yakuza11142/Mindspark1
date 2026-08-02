import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class MathParser extends StatelessWidget {
  final String latex;
  const MathParser({super.key, required this.latex});

  @override
  Widget build(BuildContext context) {
    // 1. Constrained Box prevents the headless web view from triggering infinite height layout crashes
    return SizedBox(
      width: double.infinity,
      child: TeXView(
        // Enforces full web view height matching for text updates
        renderingEngine: TeXViewRenderingEngine.katex, 
        child: TeXViewDocument(
          latex,
          style: const TeXViewStyle(
            contentColor: Colors.white,
            backgroundColor: Colors.transparent,
            fontStyle: TeXViewFontStyle(fontSize: 14),
          ),
        ),
        // 2. Smooth native loading block replaces blank flashes with a clean loader layout
        loadingWidgetBuilder: (context) => const Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
