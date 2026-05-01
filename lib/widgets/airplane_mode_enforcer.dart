import 'package:flutter/material.dart';

class AirplaneModeEnforcer extends StatelessWidget {
  const AirplaneModeEnforcer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.amber.withOpacity(0.2),
      child: const Row(
        children:[
          Icon(Icons.airplanemode_active, color: Colors.amber),
          SizedBox(width: 10),
          Expanded(child: Text("For maximum focus, please turn on Airplane Mode. MindSpark will run 100% offline.", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}