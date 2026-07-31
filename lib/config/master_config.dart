class MasterConfig {
  // FIXED: Environment is now dynamically read out of the compilation command state parameters.
  // Running 'flutter run' or 'flutter build --release' handles configuration selection automatically.
  static const bool isDev = !kReleaseMode;
  
  // FIXED: Logs are cleanly deactivated on deployment production builds to secure operational telemetry
  static const bool enableLogs = !kReleaseMode;

  // FIXED: Resolved Android emulator localhost address routing loops automatically.
  // Points to 10.0.2.2 on Android emulators to cleanly forward network loops back to your local machine server.
  static const String serverUrl = String.fromEnvironment(
    'SERVER_URL',
    defaultValue: kReleaseMode 
        ? "https://api.mindspark.app" 
        : "http://10.0.2.2:8080",
  );
}

// Simple fallback declaration to ensure kReleaseMode flags map without separate foundation packages
const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');
