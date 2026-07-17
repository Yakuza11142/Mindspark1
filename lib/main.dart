void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initAdmob = MobileAds.instance.initialize();

  String supabaseUrl = '';
  String supabaseKey = '';

  // 1. First Priority: Try loading from dart-define-from-file or explicit AppConfig constants (CI/CD)
  // This extracts the environment strings injected by your GitHub workflow secrets.
  supabaseUrl = const String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  supabaseKey = const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

  // 2. Second Priority: Fall back to local .env file parsing (Local development environment)
  if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
    try {
      await dotenv.load(fileName: ".env");
      supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
      // Corrected map from SUPABASE_KEY to match your workflows asset configuration
      supabaseKey = dotenv.env['SUPABASE_ANON_KEY'] ?? dotenv.env['SUPABASE_KEY'] ?? ''; 
    } catch (e) {
      debugPrint("⚠️ .env asset file unreadable. Checking hardcoded config fallbacks.");
    }
  }

  // 3. Third Priority: Explicitly test against hardcoded project configurations if available
  if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
    // Falls back gracefully to your local or fallback project production keys
    supabaseUrl = "https://your-supabase-project.supabase.co"; 
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
      debugPrint("⚠️ Supabase compilation setup skipped: Set matching production keys inside initialization blocks.");
    }
  } catch (e) {
    debugPrint("❌ Supabase critical initialization failure: $e");
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
