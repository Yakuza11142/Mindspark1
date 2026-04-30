import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class InfiniteScanner {
  bool _isProcessing = false;
  final FaceDetector _detector = FaceDetector(options: FaceDetectorOptions(
    enableTracking: true, // Crucial for "Infinite" persistence
    performanceMode: FaceDetectorMode.fast 
  ));

  // This runs infinitely until you stop it
  void startInfiniteScan(Stream<InputImage> imageStream) {
    imageStream.listen((image) async {
      if (_isProcessing) return; // Skip frame if still calculating
      _isProcessing = true;

      final faces = await _detector.processImage(image);
      for (var face in faces) {
        _handleRecognition(face);
      }

      _isProcessing = false;
    });
  }

  void _handleRecognition(Face face) {
    final String id = face.trackingId.toString();
    // 0-second check against Mind Spark Database
    final profile = IdentityRegistry.getName(id); 
    
    if (profile != null) {
      print("Recognized: ${profile['name']}");
      // AH reacts here
    }
  }
}
