import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/ad_manager.dart';
import 'services/brain_service.dart';
import 'services/media_engine.dart';
import 'services/audio_service.dart';
import 'services/currency_manager.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();// Check for any payments that didn't upload yesterday and push them to the cloud now
UnfailingPaymentQueue.syncPaymentsWithServer();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AdManager()..init()),
        Provider(create: (_) => BrainService()),
        Provider(create: (_) => MediaEngine()),
        Provider(create: (_) => AudioService()),
        ChangeNotifierProvider(create: (_) => CurrencyManager()..init(false)),
      ],
      child: const MindSparkApp(),
    ),
  );
}

class MindSparkApp extends StatelessWidget {
  const MindSparkApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0F172A)),
      home: const SplashScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/security_service.dart';
// ... imports ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. SECURITY CHECK
  bool isHacked = await SecurityService.isDeviceCompromised();
  if (isHacked) {
    // If hacked, crash the app intentionally or show error
    runApp(const HackedAppScreen());
    return;
  }

  // ... rest of your init code ...
  runApp(const MindSparkApp());
}

// SCREEN TO SHOW HACKERS
class HackedAppScreen extends StatelessWidget {
  const HackedAppScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 80, color: Colors.red),
              SizedBox(height: 20),
              Text("Security Alert", style: TextStyle(color: Colors.white, fontSize: 24)),
              Text("This device is rooted/modified.", style: TextStyle(color: Colors.white54)),
              Text("MindSpark Elite cannot run here.", style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // 1. Initialize Flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Load the secret .env vault
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error: Could not find .env file. Check Step No. 1.");
  }

  // 3. Power up Supabase with your CEO keys
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  runApp(const MindSparkApp());
}

class MindSparkApp extends StatelessWidget {
  const MindSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // CEO Aesthetic
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bolt, color: Colors.cyanAccent, size: 50),
            const SizedBox(height: 20),
            const Text(
              "MIND SPARK CORE",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            Text(
              "STATUS: ONLINE | CEO: VERIFIED",
              style: TextStyle(color: Colors.cyanAccent.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:arcore_flutter_plus/arcore_flutter_plus.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:google_ml_kit_face_detection/google_ml_kit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('studentBox'); 
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SparkInfiniteAR()));
}

class SparkInfiniteAR extends StatefulWidget {
  @override
  _SparkInfiniteARState createState() => _SparkInfiniteARState();
}

class _SparkInfiniteARState extends State<SparkInfiniteAR> {
  ArCoreController? arCoreController;
  final Box studentBox = Hive.box('studentBox');
  late FaceDetector _faceDetector;
  tfl.Interpreter? _interpreter;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _faceDetector = FaceDetector(options: FaceDetectorOptions(
      enableTracking: true,
      performanceMode: FaceDetectorMode.accurate,
    ));
    _loadModel();
  }

  Future<void> _loadModel() async {
    _interpreter = await tfl.Interpreter.fromAsset('mobilefacenet.tflite');
  }

  // INFINITE SCAN: This logic would be hooked into a camera stream
  // to constantly compare the current face to your Edge Memory (Hive)
  void _infiniteFaceScan(InputImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;

    final faces = await _faceDetector.processImage(image);
    for (var face in faces) {
      // 1. Extract Face Vector (The mathematical 'face signature')
      List currentFaceVector = [/* data from model */]; 

      // 2. SEARCH EVERYTHING: Compare against every student in Hive
      for (var key in studentBox.keys) {
        var student = studentBox.get(key);
        if (_isMatch(currentFaceVector, student['face_vector'])) {
          print("RECOGNIZED: ${student['name']}");
          _updateHologramStatus(student['name'], student['stats']);
        }
      }
    }
    _isProcessing = false;
  }

  // Simple math to see if two face vectors are the same person
  bool _isMatch(List vec1, List vec2) {
    // Euclidean distance logic goes here
    return true; 
  }

  void _updateHologramStatus(String name, String stats) {
    // This would update the 3D text in real-time
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spark: Infinite Recognition"), backgroundColor: Colors.black),
      body: ArCoreView(
        onArCoreViewCreated: (controller) => arCoreController = controller,
        enableTapRecognizer: true,
      ),
    );
  }

  @override
  void dispose() {
    _faceDetector.close();
    _interpreter?.close();
    arCoreController?.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plus/arcore_flutter_plus.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() => runApp(MaterialApp(home: SparkGestureAR()));

class SparkGestureAR extends StatefulWidget {
  @override
  _SparkGestureARState createState() => _SparkGestureARState();
}

class _SparkGestureARState extends State<SparkGestureAR> {
  ArCoreController? arCoreController;
  int nodeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spark: Gesture Control")),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true, // Enables standard tap gestures
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    
    // GESTURE: Tap a plane to create a new "Secondary" hologram
    arCoreController?.onPlaneTap = _onPlaneTapHandler;

    // GESTURE: Tap an existing hologram to DELETE it
    arCoreController?.onNodeTap = (nodeName) {
      _deleteHologram(nodeName);
    };
  }

  void _onPlaneTapHandler(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    nodeCount++;
    _createHologram(hit, "Spark_$nodeCount");
  }

  void _createHologram(ArCoreHitTestResult hit, String name) {
    // Primary "Spark" hologram
    final sparkNode = ArCoreReferenceNode(
      name: name,
      object3DFileName: "spark.glb",
      position: hit.pose.translation,
      rotation: hit.pose.rotation,
    );

    // Secondary Hologram (e.g., a data tag floating above)
    final secondaryNode = ArCoreNode(
      shape: ArCoreText(text: "Data: $name", extrusionDepth: 0.02),
      position: hit.pose.translation + vector.Vector3(0, 0.3, 0), // Floats higher
      name: "${name}_tag",
    );

    arCoreController?.addArCoreNodeWithAnchor(sparkNode);
    arCoreController?.addArCoreNodeWithAnchor(secondaryNode);
    print("Saved $name to the Edge World.");
  }

  void _deleteHologram(String nodeName) {
    // Removes the specific node by its unique name
    arCoreController?.removeNode(nodeName: nodeName);
    print("Deleted $nodeName from the real world.");
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plus/arcore_flutter_plus.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class SparkInfiniteAR extends StatefulWidget {
  @override
  _SparkInfiniteARState createState() => _SparkInfiniteARState();
}

class _SparkInfiniteARState extends State<SparkInfiniteAR> {
  ArCoreController? arCoreController;
  
  // 6'2" base height converted to meters for the A71
  double baseHeightMeters = 1.8796; 
  double twoInchesInMeters = 0.0508;

  void _onPlaneTapHandler(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    
    // Logic: Default to 6'2", but if a person is detected, 
    // we calculate their height and add 2 inches.
    double finalHeight = _calculateDynamicHeight(); 

    _projectTallSpark(hit, finalHeight);
  }

  double _calculateDynamicHeight() {
    // In a real scan, you'd get the 'y' coordinate of the top of a detected face.
    // Here we set the base. If a student is 6'4", Spark becomes 6'6".
    double detectedPersonHeight = 1.83; // Example: 6'0" person detected
    
    if (detectedPersonHeight + twoInchesInMeters > baseHeightMeters) {
      return detectedPersonHeight + twoInchesInMeters;
    }
    return baseHeightMeters;
  }

  void _projectTallSpark(ArCoreHitTestResult hit, double height) {
    final sparkNode = ArCoreReferenceNode(
      name: "GiantSpark",
      object3DFileName: "spark.glb",
      position: hit.pose.translation,
      // Scaling the 3D model to stand at the calculated height
      scale: vector.Vector3(height, height, height), 
    );

    arCoreController?.addArCoreNodeWithAnchor(sparkNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Spark: 6'2\"+ Giant Mode")),
      body: ArCoreView(
        onArCoreViewCreated: (c) => arCoreController = c,
        enableTapRecognizer: true,
      ),
    );
  }
}
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:groq_sdk/groq_sdk.dart';

class SparkConsensusBrain {
  final groq = Groq('YOUR_GROQ_KEY');

  Future<Map<String, String>> fetchTripleResponse(String prompt) async {
    // 1. Run all three models in parallel (Parallel Processing)
    final results = await Future.wait([
      _askGPT(prompt),
      _askGemini(prompt),
      _askGroq(prompt),
    ]);

    return {
      'gpt': results[0],
      'gemini': results[1],
      'groq': results[2],
    };
  }

  Future<String> _askGPT(String p) async {
    final chat = await OpenAI.instance.chat.create(
      model: "gpt-5.5-preview", 
      messages: [OpenAIChatCompletionChoiceMessageModel(content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(p)], role: OpenAIChatMessageRole.user)],
    );
    return chat.choices.first.message.content!.first.text!;
  }

  Future<String> _askGemini(String p) async {
    final res = await Gemini.instance.text(p);
    return res?.output ?? "";
  }

  Future<String> _askGroq(String p) async {
    final chat = await groq.startChat();
    final res = await chat.sendMessage(p);
    return res.choices.first.message.content;
  }
}
void _processConsensus(String prompt) async {
  final responses = await _brain.fetchTripleResponse(prompt);
  
  // LOGIC: Use Groq for speed, Gemini for data, and GPT for logic
  String finalAdvice = "Gemini says: ${responses['gemini']}. GPT reasoning: ${responses['gpt']}";
  
  setState(() {
    // Hologram physical update
    _sparkHeight += 0.05; // Significant "evolution" jump
    _sparkSpeak("My consensus brain has analyzed your data using three distinct models.");
  });
}
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/main_layout_screen.dart';
import '../screens/age_gate_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.session != null) {
          return const MainLayoutScreen();
        }
        return const AgeGateScreen(); // Sends to Onboarding/Login
      },
    );
  }
}
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCoreConfig {
  // Draws from --dart-define or environment variables
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static Future<void> initialize() async {
    if (url.isEmpty || anonKey.isEmpty) {
      print("❌ ERROR: Supabase Keys are missing from environment.");
      return;
    }

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        eventsPerSecond: 10,
      ),
    );
    print("☁️ SUPABASE CLOUD CONNECTED.");
  }

  static SupabaseClient get client => Supabase.instance.client;
}


