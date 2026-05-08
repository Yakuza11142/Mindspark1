import 'package:flutter/material.dart';
class VersionFooter extends StatelessWidget {
  const VersionFooter({super.key});
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(20),
    child: Center(child: Text("Mind Spark v1.0.0", style: TextStyle(color: Colors.grey))),
  );
}