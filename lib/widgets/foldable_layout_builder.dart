import 'package:flutter/material.dart';

class FoldableLayoutBuilder extends StatelessWidget {
  final Widget mainContent;
  final Widget sideContent;
  const FoldableLayoutBuilder({super.key, required this.mainContent, required this.sideContent});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 600) {
      // Tablet / Foldable open state
      return Row(children:[Expanded(flex: 1, child: mainContent), Expanded(flex: 1, child: sideContent)]);
    }
    // Normal phone
    return mainContent;
  }
}