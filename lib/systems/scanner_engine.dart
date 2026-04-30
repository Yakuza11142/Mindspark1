import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class ScannerEngine {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true, // For precise AH interaction
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  Future<void> scanAll(InputImage image, Function(List<Face>) onDetected) async {
    final List<Face> faces = await _faceDetector.processImage(image);
    onDetected(faces); // Triggers AH reaction for every face found
  }

  void dispose() => _faceDetector.close();
}
