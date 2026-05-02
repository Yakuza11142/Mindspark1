import 'package:flutter/material.dart';

class DataSaverBadge extends StatelessWidget {
  const DataSaverBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: Colors.green[900], borderRadius: BorderRadius.circular(10)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children:[
          Icon(Icons.data_saver_on, color: Colors.greenAccent, size: 12),
          SizedBox(width: 4),
          Text("0MB Data Mode", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}