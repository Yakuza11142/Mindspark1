import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:developer' as developer;

class OnDeviceVision {
  // Singleton pattern enforces a single instance footprint across all view updates
  OnDeviceVision._internal();
  static final OnDeviceVision instance = OnDeviceVision._internal();

  static TextRecognizer? _textRecognizer;
  static bool _isProcessingFrame = false;
  static bool _isPermanentlyDisposed = false;

  /// Internal property accessor guarantees lazy initialization only when actively required
  static TextRecognizer? _getOrCreateRecognizer() {
    if (_isPermanentlyDisposed) return null;
    _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
    return _textRecognizer;
  }

  /// Processes on-device optical character recognition safely across shared system loops
  static Future<String> scanText(String imagePath) async {
    // Block execution paths permanently if the core engine has been decoupled by a cleanup sequence
    if (_isPermanentlyDisposed) {
      developer.log("⚠️ OnDeviceVision: Engine instance has been permanently closed. Dropping extraction request.");
      return "";
    }

    // Drop execution early if a heavy image mutation frame is currently occupying the platform channel
    if (_isProcessingFrame) {
      developer.log("⏳ OnDeviceVision: Platform channel busy processing a concurrent frame request. Dropping overlap.");
      return "";
    }

    developer.log("👁️ OnDeviceVision: Executing high-speed on-device text scanning pass.");
    
    try {
      final TextRecognizer? recognizer = _getOrCreateRecognizer();
      if (recognizer == null) {
        throw StateError("Attempted to access native recognizer pointers after execution teardown.");
      }

      // Safely activate processing flags after confirming structural instance validation states
      _isProcessingFrame = true;
      
      final inputImage = InputImage.fromFilePath(imagePath);
      final RecognizedText recognizedText = await recognizer.processImage(inputImage);

      final String extractedText = recognizedText.text;
      if (extractedText.isEmpty) {
        return "";
      }

      return _sanitizeExtractedText(extractedText);
    } catch (e, stackTrace) {
      developer.log("❌ OnDeviceVision: Extraction pipeline encountered a physical hardware error", error: e, stackTrace: stackTrace);
      return "Error reading text on-device.";
    } finally {
      // Always guarantee the processing atomic latch releases regardless of early exits or hardware timeouts
      _isProcessingFrame = false;
    }
  }

  /// Cleans and formats basic characters to maximize text presentation metrics
  static String _sanitizeExtractedText(String text) {
    return text
        .replaceAll('\r', '') 
        .replaceAll(RegExp(r'[ \t]+'), ' ') 
        .trim();
  }

  /// Call this lifecycle hook upon global application shutdown sequences to completely free up system memory
  static Future<void> dispose() async {
    if (_isPermanentlyDisposed) return;
    _isPermanentlyDisposed = true; // Lockdown the state machine permanently before running network close commands
    
    developer.log("⚙️ OnDeviceVision: Releasing core native text recognition model pointers safely.");
    
    try {
      if (_textRecognizer != null) {
        await _textRecognizer!.close();
        _textRecognizer = null; 
      }
    } catch (e) {
      developer.log("Error closing native recognizer pointers: $e");
    } finally {
      _isProcessingFrame = false;
    }
  }
}
