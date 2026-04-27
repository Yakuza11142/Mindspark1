import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import '../config/secrets.dart';

class VisionEngine {
  late GenerativeModel _vision;
  final ImagePicker _picker = ImagePicker();

  VisionEngine() {
    _vision = GenerativeModel(model: 'gemini-pro-vision', apiKey: Secrets.geminiKey);
  }

  Future<String?> snapAndSolve() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (photo == null) return null;
    
    final bytes = await photo.readAsBytes();
    try {
      final res = await _vision.generateContent([
        Content.multi([TextPart("Solve this problem."), DataPart('image/jpeg', bytes)])
      ]);
      return res.text;
    } catch (e) { return "Error analyzing image."; }
  }
}