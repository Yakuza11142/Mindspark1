import 'package:flutter/material.dart';
class ArPermissionGate extends StatelessWidget {
  const ArPermissionGate({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.black, body: Center(child: Text("Requesting Camera & Spatial Mapping Access...")));
  }
}