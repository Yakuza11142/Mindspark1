import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../data/workers/isolated_proof_compiler.dart';

enum CoreProcessState { uninitialized, orchestratingInference, processingIsolateChecks, certifiedSuccess }

class FortressTutorProvider with ChangeNotifier {
  final IsolatedProofCompiler _proofCompiler = IsolatedProofCompiler();
  final Dio _networkClient = Dio();

  CoreProcessState _processState = CoreProcessState.uninitialized;
  String _diagnosticMonitorOutput = "System Standing By.";
  String _certifiedHologramOutput = "";

  CoreProcessState get processState => _processState;
  String get diagnosticMonitorOutput => _diagnosticMonitorOutput;
  String get certifiedHologramOutput => _certifiedHologramOutput;

  /// Submits queries straight to the OpenAI/Groq API interfaces.
  /// Runs a recursive self-correcting loop until an inference branch survives the non-AI compiler constraints.
  Future<void> computeGroundedAxioms(String humanVoiceCommand, String targetEndpointApiKey) async {
    _processState = CoreProcessState.orchestratingInference;
    _diagnosticMonitorOutput = "🧠 System Core: Launching parallel multi-branch generation tracks via server-enforced JSON structures...";
    notifyListeners();

    bool absoluteTruthVerified = false;
    int systemCorrectionCycles = 0;
    String feedbackContextBacklog = ""; 

    // Rigid schema structural rules forced directly onto the model generation layer
    final Map<String, dynamic> rigidJsonSchemaContract = {
      "type": "object",
      "properties": {
        "input_joules": {"type": "number"},
        "output_joules": {"type": "number"},
        "temperature_kelvin": {"type": "number"},
        "formal_proof": {"type": "string", "description": "Must initialize with the phrase 'Theorem:' and close with 'QED'. Do not include guessing tokens or filler language words."}
      },
      "required": ["input_joules", "output_joules", "temperature_kelvin", "formal_proof"],
      "additionalProperties": false
    };

    while (!absoluteTruthVerified) {
      systemCorrectionCycles++;
      
      try {
        final apiResponse = await _networkClient.post(
          'https://openai.com',
          options: Options(headers: {
            'Authorization': 'Bearer $targetEndpointApiKey',
            'Content-Type': 'application/json',
          }),
          data: {
            'model': 'gpt-4o',
            // Server-Level Binding: Aligned to token-level constraints to prevent markdown wrap variations
            'response_format': {
              'type': 'json_object',
              'schema': rigidJsonSchemaContract
            },
            'messages': [
              {
                'role': 'system',
                'content': '''You are a sterile scientific computing interface. You output structured data metrics matching the required schema exactly. 
                  Do not output human conversational introductory words or conversational transitions.
                  $feedbackContextBacklog'''
              },
              {'role': 'user', 'content': humanVoiceCommand}
            ],
            'n': 3 // Spawns 3 alternative thought paths concurrently for multi-branch tree pruning
          },
        );

        if (apiResponse.statusCode != 200) {
          _diagnosticMonitorOutput = "🚨 Network Outage: Cloud endpoint returned a connection exception. Retrying track...";
          notifyListeners();
          await Future.delayed(const Duration(seconds: 1));
          continue;
        }

        final List<dynamic> derivedChoices = apiResponse.data['choices'] ?? [];
        List<String> collectedJsonPayloads = [];

        for (var choice in derivedChoices) {
          if (choice['message']?['content'] != null) {
            collectedJsonPayloads.add(choice['message']['content'].toString());
          }
        }

        // Shift processing strings entirely out of the UI layer to run raw validation matrices
        _processState = CoreProcessState.processingIsolateChecks;
        _diagnosticMonitorOutput = "⚙️ Verification Kernel: Running background isolate calculations... (Cycle Count: #$systemCorrectionCycles)";
        notifyListeners();

        final compilationResult = await _proofCompiler.filterAndVerifyBranches(
          IsolateCompilationPayload(rawInferenceCandidates: collectedJsonPayloads),
        );

        _diagnosticMonitorOutput = compilationResult['logMessage'].toString();
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 600)); // Pacing threshold for UI readout tracking

        if (compilationResult['success'] == true) {
          _certifiedHologramOutput = compilationResult['extractedProof'].toString();
          absoluteTruthVerified = true;
        } else {
          // 🚀 AGENTIC SYSTEM FEEDBACK: Inject the compilation error string directly back into the system context
          feedbackContextBacklog = "🚨 PREVIOUS ATTEMPT REJECTED BY SYSTEM LAWS: ${compilationResult['logMessage']}. Re-calculate your data parameters and fix structural syntax bugs.";
        }

      } catch (pipelineException) {
        _diagnosticMonitorOutput = "⚠️ Execution Exception Caught: $pipelineException. Re-aligning thread data paths...";
        notifyListeners();
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    _processState = CoreProcessState.certifiedSuccess;
    _diagnosticMonitorOutput = "🔒 AXIOM VERIFIED WITH 100% MATHEMATICAL PRECISION:\n$_certifiedHologramOutput";
    notifyListeners();
  }
}
