import 'dart:async';
import 'package:flutter/foundation.dart';
import 'axiom_linter_engine.dart'; // Verified configuration path mapping

class IsolatedProofCompiler {
  /// Evaluates model choices inside a true independent OS background thread.
  /// Decouples execution entirely from your primary 6ft AR view controller thread.
  Future<Map<String, dynamic>> filterAndVerifyBranches(List<String> rawInferenceCandidates) async {
    // FIXED: Patched the missing return path block safely.
    // FIXED: Sent a primitive List<String> across the thread barrier instead of a custom class instance.
    // This guarantees total isolate memory compliance and prevents runtime ArgumentErrors.
    try {
      return await compute(_compileAndProcessStream, rawInferenceCandidates);
    } catch (fatalIsolateException) {
      debugPrint("🚨 Background Thread Crash intercepted: ${fatalIsolateException.toString()}");
      return {
        'success': false,
        'extractedProof': "",
        'logMessage': "❌ Isolate Thread Failure: ${fatalIsolateException.toString()}",
      };
    }
  }

  // FIXED: Changed parameter to accept primitive types to adhere strictly to Dart isolate heap boundaries
  static Map<String, dynamic> _compileAndProcessStream(List<String> rawInferenceCandidates) {
    final linterEngine = AxiomLinterEngine();

    // Cycle through all alternate paths sent down by the multi-prompt engine array
    final int candidateCount = rawInferenceCandidates.length;
    for (int index = 0; index < candidateCount; index++) {
      final String rawCandidateString = rawInferenceCandidates[index];

      try {
        final verifiablyCleanData = linterEngine.evaluatePayloadSanity(rawCandidateString);

        // Break loop and return immediately the millisecond a choice clears all validation gates
        return {
          'success': true,
          'extractedProof': verifiablyCleanData['formal_proof'].toString(),
          'logMessage': "🔒 Branch matrix index #${index + 1} cleared all strict physical verification parameters.",
        };
      } catch (programmaticViolation) {
        // Log the failure to the debug stream context and advance to evaluate the next sibling node
        debugPrint("🌳 MCTS Pruned Node Reference #${index + 1} -> ${programmaticViolation.toString()}");
      }
    }

    // FIXED: Ensured a baseline fallback map is returned under all possible branch execution states
    return {
      'success': false,
      'extractedProof': "",
      'logMessage': "❌ Integration Failure: All engine generations violated physical boundaries or structural syntax invariants.",
    };
  }
}
