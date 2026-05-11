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

  // 1. Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("⚠️  Warning: .env file not found - using default values");
  }

  // 2. Initialize Supabase
  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
    );
    print("☁️  Supabase initialized successfully");
  } catch (e) {
    print("❌ Supabase initialization error: $e");
  }

  // 3. Start the app with all providers
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
      title: 'MindSpark Elite',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF6366F1),
      ),
      home: const SplashScreen(),
    );
  }
}
