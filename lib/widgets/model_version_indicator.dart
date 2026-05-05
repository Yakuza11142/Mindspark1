import 'package:flutter/material.dart';
import '../engines/millisecond_updater.dart';

class ModelVersionIndicator extends StatelessWidget {
  final bool isPro;
  const ModelVersionIndicator({super.key, required this.isPro});

  @override
  Widget build(BuildContext context) {
    String modelText = isPro 
      ? "🧠 FUSION: ${MillisecondUpdater.groqModel} + ${MillisecondUpdater.openAiModel}" 
      : "🧠 LITE: ${MillisecondUpdater.geminiModel}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(modelText, style: TextStyle(color: isPro ? Colors.purpleAccent : Colors.grey, fontSize: 10)),
    );
  }
}