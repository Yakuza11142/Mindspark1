import 'package:flutter/foundation.dart';
import '../../core/physics/axiom_linter_engine.dart';

class IsolateCompilationPayload {
  final List<String> rawInferenceCandidates;
  const IsolateCompilationPayload({required this.rawInferenceCandidates});
}

class IsolatedProofCompiler {
  /// Evaluates model choices inside a true independent OS background thread.
  /// Decouples execution entirely from your primary 6ft AR view controller thread.
  Future<Map<String, dynamic>> filterAndVerifyBranches(IsolateCompilationPayload payload) async {
    // Spawns a true standalone background isolate context using native architecture
    return await Isolate.run(() => _compileAndProcessStream(payload));
  }

  static Map<String, dynamic> _compileAndProcessStream(IsolateCompilationPayload payload) {
    final linterEngine = AxiomLinterEngine();
    
    // Cycle through all alternate paths sent down by the multi-prompt engine array
    for (int index = 0; index < payload.rawInferenceCandidates.length; index++) {
      final String rawCandidateString = payload.rawInferenceCandidates[index];
      
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

    return {
      'success': false,
      'extractedProof': "",
      'logMessage': "❌ Integration Failure: All engine generations violated physical boundaries or structural syntax invariants.",
    };
  }
}
