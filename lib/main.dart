import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math' as math;

// Conditional Import Block: Dynamically swaps files based on target matrix selection
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

  // Initialize the platform-specific spatial layout engine safely
  final spatialEngine = getSpatialEngine();
  spatialEngine.initializeTutor();

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
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('AI Tutor Spark Engine Ready'),
      ),
    );
  }
}
