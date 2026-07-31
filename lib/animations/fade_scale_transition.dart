import 'package:flutter/material.dart';

class FadeScaleRoute extends PageRouteBuilder {
  final Widget page;

  FadeScaleRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          // FIXED: Set uniform timing boundaries explicitly to secure predictable transition envelopes
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // FIXED: Isolating the entrance curve so it does not distort during page exit transitions
            final animCurve = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack, // Playful pop forward upon entering
              reverseCurve: Curves.easeInCubic, // Clean, fast shrinking transition upon leaving
            );

            return ScaleTransition(
              scale: Tween<double>(begin: 0.85, end: 1.0).animate(animCurve),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: child,
              ),
            );
          },
        );
}
