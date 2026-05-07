import 'package:flutter/material.dart';
import '../services/google_play_policy_service.dart';

class SubscriptionTermsFooter extends StatelessWidget {
  const SubscriptionTermsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        GooglePlayPolicyService.subTerms,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, color: Colors.white38),
      ),
    );
  }
}