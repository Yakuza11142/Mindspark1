import 'dart:convert';

class ProductionAxiomException implements Exception {
  final String message;
  const ProductionAxiomException(this.message);
  @override
  String toString() => '🚨 Axiom Linter Engine Fault: $message';
}

class AxiomLinterEngine {
  /// Evaluates the physical validity and syntax profile of raw model payloads.
  /// Throws an explicit exception the millisecond any rule of physics or linter condition is violated.
  Map<String, dynamic> evaluatePayloadSanity(String rawJsonPayload) {
    final Map<String, dynamic> extractedTree;
    try {
      extractedTree = jsonDecode(rawJsonPayload) as Map<String, dynamic>;
    } catch (_) {
      throw const ProductionAxiomException("Syntax compile failure: Model failed to emit valid JSON data.");
    }

    // 1. Strict Contract Layout Gate
    final mandatoryParameters = ['input_joules', 'output_joules', 'temperature_kelvin', 'formal_proof'];
    for (final parameter in mandatoryParameters) {
      if (!extractedTree.containsKey(parameter) || extractedTree[parameter] == null) {
        throw ProductionAxiomException("Structural breach: Mandatory parameter matrix missing '$parameter'.");
      }
    }

    final double inputEnergy = (extractedTree['input_joules'] as num).toDouble();
    final double outputEnergy = (extractedTree['output_joules'] as num).toDouble();
    final double absoluteTemperature = (extractedTree['temperature_kelvin'] as num).toDouble();
    final String textualProof = extractedTree['formal_proof'] as String;

    // 2. Thermodynamic Absolute Zero Frontier Check
    if (absoluteTemperature < 0.0) {
      throw const ProductionAxiomException("Boundary Exception: Calculated kinetic temperature falls below Absolute Zero.");
    }

    // 3. First Law of Thermodynamics Compliance Check (Conservation of Energy)
    if (inputEnergy <= 0.0) {
      throw const ProductionAxiomException("Mathematical boundary failure: Input baseline energy must be a positive non-zero value.");
    }

    final double efficiencyRatio = outputEnergy / inputEnergy;
    if (efficiencyRatio > 1.0) {
      throw ProductionAxiomException(
        "Conservation of Energy Breach: Perpetual system rejected. Real-world efficiency cannot exceed 100%. Calculated at: ${(efficiencyRatio * 100).toStringAsFixed(6)}%."
      );
    }

    // 4. Strict Lexical Filter (Eliminates All Probabilistic Guesswork Filler Words)
    final RegExp ambiguityLinterRegex = RegExp(
      r'\b(think|maybe|approximate|approximately|guess|probably|perhaps|estimate|estimated|around|roughly|suppose|supposedly)\b',
      caseSensitive: false,
    );

    if (ambiguityLinterRegex.hasMatch(textualProof)) {
      final illegalToken = ambiguityLinterRegex.firstMatch(textualProof)?.group(0);
      throw ProductionAxiomException("Hallucination Token Caught: Conversational guess modifier detected -> '$illegalToken'.");
    }

    // 5. Explicit Structural Formalization Anchor Gates
    final String scrubbedProof = textualProof.trim().toLowerCase();
    if (!scrubbedProof.startsWith("theorem") || !scrubbedProof.endsWith("qed")) {
      throw const ProductionAxiomException("Axiomatic boundary failure: Output text structure must strictly initialize with 'Theorem' and terminate with 'QED'.");
    }

    return extractedTree;
  }
}
