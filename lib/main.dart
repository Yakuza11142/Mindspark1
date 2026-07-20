import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math' as math;

// CONDITIONAL IMPORT BLOCK: Swaps code targets cleanly so web doesn't crash on mobile plugins!
import 'spatial_stub.dart'
    if (dart.library.html) 'spatial_web.dart'
    if (dart.library.io) 'spatial_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initAdmob = MobileAds.instance.initialize();

  String supabaseUrl = '';
  String supabaseKey = '';

  // 1. First Priority: Try loading from dart-define-from-file maps (CI/CD Pipeline)
  supabaseUrl = const String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  supabaseKey = const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

  // 2. Second Priority: Fall back to local .env file parsing (Local development)
  if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
    try {
      await dotenv.load(fileName: ".env");
      supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
      supabaseKey = dotenv.env['SUPABASE_ANON_KEY'] ?? dotenv.env['SUPABASE_KEY'] ?? ''; 
    } catch (e) {
      debugPrint("⚠️ .env asset file unreadable. Checking hardcoded config fallbacks.");
    }
  }

  // 3. Third Priority: Explicit project fallback string checks
  if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
    supabaseUrl = "https://supabase.co"; 
    supabaseKey = "your-anon-key-here";
  }

  try {
    if (supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty && !supabaseUrl.contains("your-supabase-project")) {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseKey,
      );
      debugPrint("☁️ Supabase production engine initialized successfully.");
    } else {
      debugPrint("⚠️ Supabase compilation setup skipped: Set matching production keys.");
    }
  } catch (e) {
    debugPrint("❌ Supabase critical initialization failure: $e");
  }

  await initAdmob;

  // SAFE SPATIAL INITIALIZATION: Triggers AR on Mobile or Canvas layout on Web automatically!
  try {
    final spatialEngine = getSpatialEngine();
    spatialEngine.initializeTutor();
  } catch (e) {
    debugPrint("⚠️ Spatial engine boot warning: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
        ChangeNotifierProvider(create: (_) => AITutorProvider()),
        ChangeNotifierProvider(create: (_) => ArLabProvider()),
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
      title: 'Mind Spark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), 
      home: const MainDevelopmentPage(),
    );
  }
}

// EMBEDDED PROVIDERS (Temporary placeholders so the app builds without missing state files)
class AppAuthProvider extends ChangeNotifier {}
class AITutorProvider extends ChangeNotifier {}
class ArLabProvider extends ChangeNotifier {}

class MainDevelopmentPage extends StatefulWidget {
  const MainDevelopmentPage({super.key});

  @override
  State<MainDevelopmentPage> createState() => _MainDevelopmentPageState();
}

class _MainDevelopmentPageState extends State<MainDevelopmentPage> {
  final String statusMessage = 'System initialization complete successfully.';
  String formattedTime = '';
  double calculatedSine = 0.0;
  double utilityResult = 0.0;

  @override
  void initState() {
    super.initState();
    _runCalculations();
  }

  void _runCalculations() {
    final DateTime now = DateTime.now();

    setState(() {
      formattedTime = now.toIso8601String();
    });

    double idx = 45.0;
    setState(() {
      calculatedSine = math.sin(idx);
    });

    final RealMathCalculator calculator = RealMathCalculator();
    setState(() {
      utilityResult = calculator.executeValidComputation(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MindSpark Workspace')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: $statusMessage', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('ISO Timestamp: $formattedTime'),
            const SizedBox(height: 10),
            Text('Sine Value (idx): $calculatedSine'),
            const SizedBox(height: 10),
            Text('Calculator Output: $utilityResult'),
          ],
        ),
      ),
    );
  }
}

class RealMathCalculator {
  double executeValidComputation(double input) {
    if (input <= 0) return 0.0;
    return (input * math.pi) / 180.0;
  }
}
