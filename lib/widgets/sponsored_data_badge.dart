import 'package:flutter/material.dart';

class SponsoredDataBadge extends StatelessWidget {
  final bool isSponsored;
  const SponsoredDataBadge({super.key, required this.isSponsored});

  @override
  Widget build(BuildContext context) {
    if (!isSponsored) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.green[900], borderRadius: BorderRadius.circular(15)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children:[
          Icon(Icons.wifi_tethering, color: Colors.greenAccent, size: 14),
          SizedBox(width: 5),
          Text("Free Data (Sponsored)", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}