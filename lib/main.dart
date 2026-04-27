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