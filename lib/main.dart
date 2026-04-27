import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/ad_manager.dart';
import 'services/brain_service.dart';
import 'services/media_engine.dart';
import 'services/audio_service.dart';
import 'services/currency_manager.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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