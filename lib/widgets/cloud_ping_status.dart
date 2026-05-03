import 'package:flutter/material.dart';

class CloudPingStatus extends StatelessWidget {
  const CloudPingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:[
          Icon(Icons.dns, size: 12, color: Colors.greenAccent),
          SizedBox(width: 4),
          Text("Supabase DB Active", style: TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}