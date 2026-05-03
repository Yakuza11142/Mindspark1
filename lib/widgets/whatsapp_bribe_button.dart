import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../engines/viral_unlock_engine.dart';

class WhatsappBribeButton extends StatelessWidget {
  final VoidCallback onUnlocked;
  const WhatsappBribeButton({super.key, required this.onUnlocked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], padding: const EdgeInsets.all(15)),
      icon: const Icon(Icons.share, color: Colors.white),
      label: const Text("Share to 3 Friends to Unlock Predictor", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      onPressed: () async {
        await Share.share("I'm using MindSpark AI to predict my exact JAMB 2026 score. Check it out: mindspark.app");
        await ViralUnlockEngine.logInviteSent();
        if (await ViralUnlockEngine.isPredictorUnlocked()) onUnlocked();
      },
    );
  }
}