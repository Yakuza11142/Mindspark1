import 'package:flutter/material.dart';
import '../services/ai_version_updater.dart';

class DynamicAiBadge extends StatelessWidget {
  final bool isPro;
  const DynamicAiBadge({super.key, required this.isPro});

  @override
  Widget build(BuildContext context) {
    String modelName = isPro ? AiVersionUpdater.activeOpenAiModel : AiVersionUpdater.activeGeminiModel;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(5)),
      child: Text("Powered by $modelName", style: const TextStyle(color: Colors.cyanAccent, fontSize: 10)),
    );
  }
}