import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:mindspark/core/constants/app_theme.dart';
import 'package:mindspark/presentation/providers/auth_provider.dart';
import 'package:mindspark/presentation/providers/ai_tutor_provider.dart';
import 'package:mindspark/presentation/providers/ar_lab_provider.dart';
import 'package:mindspark/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final initAdmob = MobileAds.instance.initialize();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("⚠️ .env file not found.");
  }

  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
    );
    debugPrint("☁️ Supabase initialized");
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
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
