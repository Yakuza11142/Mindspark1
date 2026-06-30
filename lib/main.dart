import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math' as math;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initAdmob = MobileAds.instance.initialize();

  // Safe fallback configurations since .env file asset bundling is removed
  String supabaseUrl = '';
  String supabaseKey = '';

  try {
    // Attempts to load .env safely if present locally during development
    await dotenv.load(fileName: ".env");
    supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
    supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  } catch (e) {
    debugPrint("⚠️ .env file asset absent. Emplementing fallback runtime parameters.");
    // 💡 TIP: You can paste your production keys directly into these fallback variables if needed:
    supabaseUrl = "https://supabase.co";
    supabaseKey = "your-anon-key-here";
  }

  try {
    if (supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty && !supabaseUrl.contains("your-supabase-project")) {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseKey,
      );
      debugPrint("☁️ Supabase initialized");
    } else {
      debugPrint("⚠️ Supabase skipped: Set your production keys inside main.dart variables.");
    }
  } catch (e) {
    debugPrint("❌ Supabase error: $e");
  }

  await initAdmob;

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

// EMBEDDED PROVIDERS (Temporary placeholders so the app builds without the missing files)
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
