import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OnDeviceVision {
  static Future<String> scanText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    
    await textRecognizer.close();
    return recognizedText.text; // Returns the math equation or text instantly, for free.
  }
}