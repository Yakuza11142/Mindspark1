import 'package:flutter/material.dart';
import '../engines/semantic_vulgarity_analyzer.dart';
import '../engines/academic_pivot_infinite.dart';
import '../services/active_persona_manager.dart';
import 'package:provider/provider.dart';

class ChatInterceptorV2 {
  static Future<String?> processInput(BuildContext context, String userInput) async {
    final currentAh = context.read<ActivePersonaManager>().currentPersona;

    // Run the Infinite Shield
    bool isVulgar = await SemanticVulgarityAnalyzer.isVulgarOrInappropriate(userInput);

    if (isVulgar) {
      // 0 API Cost for the actual response, we use the hardcoded pivot
      return AcademicPivotInfinite.executePivot(userInput, currentAh);
    }
    
    return null; // Clean input, proceed normally
  }
}