import 'package:flutter/material.dart';

class NetworkLatencyUi extends StatelessWidget {
  final int pingMs;
  const NetworkLatencyUi({super.key, required this.pingMs});

  @override
  Widget build(BuildContext context) {
    Color c = Colors.green;
    if (pingMs > 300) c = Colors.orange;
    if (pingMs > 800) c = Colors.red;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children:[
        Icon(Icons.circle, color: c, size: 8),
        const SizedBox(width: 4),
        Text("${pingMs}ms", style: TextStyle(color: c, fontSize: 10)),
      ],
    );
  }
}