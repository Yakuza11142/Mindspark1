import 'package:flutter/material.dart';

class BrowserBackButtonHandler extends StatelessWidget {
  final Widget child;
  const BrowserBackButtonHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) return;
        // Handle web back button logic securely
      },
      child: child,
    );
  }
}