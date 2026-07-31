import 'dart:convert';
import 'package:flutter/foundation.dart';

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
      throw const ProductionAxiomException(
          "Syntax compile failure: Model failed to emit valid JSON data.");
    }

    // 1. Strict Contract Layout Gate
    final mandatoryParameters = [
      'input_joules',
      'output_joules',
      'temperature_kelvin',
      'formal_proof'
    ];
    for (final parameter in mandatoryParameters) {
      if (!extractedTree.containsKey(parameter) || extractedTree[parameter] == null) {
        throw ProductionAxiomException(
            "Structural breach: Mandatory parameter matrix missing '$parameter'.");
      }
    }

    // FIXED: Swapped out risky explicit casting loops ('as num') for robust validation checks.
    // This intercepts string or boolean anomalies smoothly without throwing unhandled TypeErrors.
    final dynamic rawInput = extractedTree['input_joules'];
    final dynamic rawOutput = extractedTree['output_joules'];
    final dynamic rawTemp = extractedTree['temperature_kelvin'];
    final dynamic rawProof = extractedTree['formal_proof'];

    if (rawInput is! num || rawOutput is! num || rawTemp is! num || rawProof is! String) {
      throw const ProductionAxiomException(
          "Type Error: Payload properties do not conform to structural numeric/string schemas.");
    }

    final double inputEnergy = rawInput.toDouble();
    final double outputEnergy = rawOutput.toDouble();
    final double absoluteTemperature = rawTemp.toDouble();
    final String textualProof = rawProof;

    // 2. FIXED: Implemented a safe thermodynamic floating-point threshold check to guard against calculation loops
    const double epsilonThreshold = 1e-6;
    if (absoluteTemperature < -epsilonThreshold) {
      throw const ProductionAxiomException(
          "Boundary Exception: Calculated kinetic temperature falls below Absolute Zero.");
    }

    // 3. First Law of Thermodynamics Compliance Check (Conservation of Energy)
    if (inputEnergy <= 0.0) {
      throw const ProductionAxiomException(
          "Mathematical boundary failure: Input baseline energy must be a positive non-zero value.");
    }

    final double efficiencyRatio = outputEnergy / inputEnergy;
    if (efficiencyRatio > 1.0) {
      throw ProductionAxiomException(
          "Conservation of Energy Breach: Perpetual system rejected. Real-world efficiency cannot exceed 100%. Calculated at: ${(efficiencyRatio * 100).toStringAsFixed(6)}%.");
    }

    // 4. Strict Lexical Filter (Eliminates All Probabilistic Guesswork Filler Words)
    final RegExp ambiguityLinterRegex = RegExp(
      r'\b(think|maybe|approximate|approximately|guess|probably|perhaps|estimate|estimated|around|roughly|suppose|supposedly)\b',
      caseSensitive: false,
    );

    if (ambiguityLinterRegex.hasMatch(textualProof)) {
      final illegalToken = ambiguityLinterRegex.firstMatch(textualProof)?.group(0);
      throw ProductionAxiomException(
          "Hallucination Token Caught: Conversational guess modifier detected -> '$illegalToken'.");
    }

    // 5. FIXED: Modified the structural anchor check to use robust regex anchoring paths.
    // This allows the linter to pass proofs containing trailing periods ('QED.') or markdown boundaries.
    final String scrubbedProof = textualProof.trim().toLowerCase();
    
    final bool hasValidPrefix = scrubbedProof.startsWith("theorem");
    // Matches 'qed' or 'qed.' at the very end of the text stream
    final bool hasValidSuffix = RegExp(r'qed\.?$').hasMatch(scrubbedProof);

    if (!hasValidPrefix || !hasValidSuffix) {
      throw const ProductionAxiomException(
          "Axiomatic boundary failure: Output text structure must strictly initialize with 'Theorem' and terminate with 'QED'.");
    }

    return extractedTree;
  }
}
