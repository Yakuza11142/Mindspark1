import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'spatial_stub.dart'
    if (dart.library.html) 'spatial_web.dart'
    if (dart.library.io) 'spatial_mobile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MindSparkApp());
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
      calculatedSine = math.sin(45.0 * (math.pi / 180.0));
      utilityResult = RealMathCalculator().executeValidComputation(45.0);
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
            Text('Sine Value: $calculatedSine'),
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
