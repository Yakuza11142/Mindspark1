import 'package:flutter/material.dart';
import 'dart:async';

class DiscountTimer extends StatefulWidget {
  const DiscountTimer({super.key});
  @override
  State<DiscountTimer> createState() => _DiscountTimerState();
}

class _DiscountTimerState extends State<DiscountTimer> {
  int seconds = 3600; // 1 Hour
  
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (t) {
      if(mounted) setState(() => seconds--);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(5),
      child: Text("SPECIAL OFFER ENDS IN: $seconds s", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }
}