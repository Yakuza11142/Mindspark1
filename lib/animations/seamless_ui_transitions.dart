import 'package:flutter/material.dart';

class SeamlessUiTransitions extends PageTransitionsBuilder {
  const SeamlessUiTransitions();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // FIXED: Combines both primary and secondary timelines.
    // As a new page pushes over this one, this screen gracefully fades down 
    // to 30% opacity instead of freezing blindly at 100%.
    return FadeTransition(
      opacity: animation,
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.3).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
