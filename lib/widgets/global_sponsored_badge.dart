import 'package:flutter/material.dart';
import '../services/global_telco_zero_rating.dart';

class GlobalSponsoredBadge extends StatefulWidget {
  const GlobalSponsoredBadge({super.key});
  @override
  State<GlobalSponsoredBadge> createState() => _GlobalSponsoredBadgeState();
}

class _GlobalSponsoredBadgeState extends State<GlobalSponsoredBadge> {
  String carrier = "";
  bool isSponsored = false;

  @override
  void initState() {
    super.initState();
    GlobalTelcoZeroRating.checkIspStatus().then((data) {
      if (mounted) setState(() { isSponsored = data['isSponsored']; carrier = data['carrier']; });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isSponsored) return const SizedBox.shrink();
    return Chip(
      backgroundColor: Colors.green[900],
      avatar: const Icon(Icons.cell_tower, color: Colors.greenAccent, size: 16),
      label: Text("$carrier Free Data", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}