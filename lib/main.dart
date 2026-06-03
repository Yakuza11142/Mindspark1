import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/ad_manager.dart';
import 'services/brain_service.dart';
import 'services/media_engine.dart';
import 'services/audio_service.dart';
import 'services/currency_manager.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("⚠️  .env not found");
  }

  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
    );
    debugPrint("☁️  Supabase initialized");
  } catch (e) {
    debugPrint("❌ Supabase error: $e");
  }

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
      title: 'Mind Spark',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF6366F1),
      ),
      home: const MainTabContainer(), // Serves as the landing hub after your splash screen finishes loading
    );
  }
}

// --- 🛡️ NEW TABBED ARCHITECTURE CONTAINER ---
class MainTabContainer extends StatelessWidget {
  const MainTabContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Three clean diagnostic tracks
      child: Scaffold(
        appBar: AppBar(
          title: const Text('🧠 MIND SPARK', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          centerTitle: true,
          backgroundColor: const Color(0xFF1E293B),
          elevation: 4,
          bottom: const TabBar(
            indicatorColor: Color(0xFF6366F1),
            labelColor: Color(0xFF6366F1),
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: "DASHBOARD"),
              Tab(icon: Icon(Icons.record_voice_over), text: "VOCAL DEV"),
              Tab(icon: Icon(Icons.psychology), text: "AR LABS"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BaseDashboardView(),
            VocalVocabularyTab(), // Your brand new feature tab
            PlaceholderArLabView(),
          ],
        ),
      ),
    );
  }
}

// --- 🗣️ NEW VOCAL VOCABULARY TAB MODULE ---
class VocalVocabularyTab extends StatefulWidget {
  const VocalVocabularyTab({super.key});

  @override
  State<VocalVocabularyTab> createState() => _VocalVocabularyTabState();
}

class _VocalVocabularyTabState extends State<VocalVocabularyTab> {
  bool _isListening = false;
  String _targetWord = "PROFOUND";
  String _definition = "Having deep insight, great knowledge, or intense meaning.";
  String _statusMessage = "Tap the microphone and say the vocabulary word aloud.";

  void _simulateVoiceCapture() {
    setState(() {
      if (!_isListening) {
        _isListening = true;
        _statusMessage = "🎙️ Analyzing speech patterns, pitch, and inflection mechanics...";
      } else {
        _isListening = false;
        _statusMessage = "✅ Perfect Pronunciation! Accuracy: 96%\n+50 Brain Points added to database.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("TODAY'S INTELLECTUAL PHRASE", style: TextStyle(color: Colors.white38, letterSpacing: 1.5, fontSize: 12))),
          const SizedBox(height: 10),
          Center(
            child: Text(
              _targetWord,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.black, color: Color(0xFF6366F1), letterSpacing: 2),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              _definition,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white70, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white12),
              ),
              child: Center(
                child: Text(_statusMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: FloatingActionButton.large(
              backgroundColor: _isListening ? Colors.redAccent : const Color(0xFF6366F1),
              onPressed: _simulateVoiceCapture,
              child: Icon(_isListening ? Icons.stop : Icons.mic, color: Colors.white, size: 36),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _isListening ? "RECORDING AUDIO CHANNELS MATRIX..." : "TAP MIC TO PRACTICE ELOCUTION",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// --- PLACEHOLDER BACKGROUND SCRAFFOLDS FOR VIEW TREE TRANSITIONS ---
class BaseDashboardView extends StatelessWidget {
  const BaseDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("📊 Main Matrix Analytics Dashboard View Layer"));
  }
}

class PlaceholderArLabView extends StatelessWidget {
  const PlaceholderArLabView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("🕶️ 3D Spatial Hologram Labs Environment Matrix"));
  }
}
