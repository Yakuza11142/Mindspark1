import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StageVoteQr extends StatelessWidget {
  const StageVoteQr({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: QrImageView(data: "https://mindspark.app/abuja-live", size: 250),
    );
  }
}