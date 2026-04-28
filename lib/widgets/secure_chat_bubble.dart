import 'package:flutter/material.dart';
import '../services/ai_hallucination_monitor.dart';

class SecureChatBubble extends StatelessWidget {
  final String rawText;
  final bool isUser;
  final Color themeColor;

  const SecureChatBubble({super.key, required this.rawText, required this.isUser, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    String safeText = isUser ? rawText : AiHallucinationMonitor.sanitizeOutput(rawText);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isUser ? themeColor.withOpacity(0.2) : Colors.white10,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isUser ? themeColor : Colors.white24),
      ),
      child: Text(safeText, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}