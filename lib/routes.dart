import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/main_layout_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      default:
        // Anti-Crash Fallback Route
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route Not Found. Re-routing to safety...")),
          ),
        );
    }
  }
}