import 'package:flutter/material.dart';
class CrossPlatformScaffold extends StatelessWidget {
  final Widget child;
  const CrossPlatformScaffold({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(body: SafeArea(child: child));
}