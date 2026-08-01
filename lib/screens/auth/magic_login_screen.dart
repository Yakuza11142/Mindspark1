import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../../services/auth/magic_link_auth.dart';
import '../../services/auth/google_one_tap.dart';

class MagicLoginScreen extends StatefulWidget {
  const MagicLoginScreen({super.key});

  @override
  State<MagicLoginScreen> createState() => _MagicLoginScreenState();
}

class _MagicLoginScreenState extends State<MagicLoginScreen> {
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  bool _linkSent = false;

  // Pre-compiled email pattern regex ensures peak garbage collection efficiency [INDEX]
  static final RegExp _emailRegexPattern = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// Triggers the background network magic link delivery sequence safely [INDEX]
  void _sendLink() async {
    final String cleanEmail = _emailCtrl.text.trim();

    // Block empty or malformed inputs early via local client-side validation gates [INDEX]
    if (cleanEmail.isEmpty || !_emailRegexPattern.hasMatch(cleanEmail)) {
      _showFeedbackSnackBar("Please enter a valid email address.");
      return;
    }

    setState(() => _loading = true);
    developer.log("🔐 LoginScreen: Dispatching magic link request sequence to auth cluster.");

    try {
      final bool success = await MagicLinkAuth.sendMagicLink(cleanEmail).timeout(
        const Duration(seconds: 10), // Guard against indefinite network freezes on weak signals [INDEX]
      );

      // Enforce a strict atomic context check boundary prior to evaluating state updates [INDEX]
      if (!mounted) {
        developer.log("⚠️ LoginScreen: Context unmounted during async fetch. Aborting state synchronization.");
        return;
      }

      setState(() {
        _loading = false;
        _linkSent = success;
      });

      if (!success) {
        _showFeedbackSnackBar("Failed to dispatch magic link. Please try again later.");
      }
    } catch (e, stackTrace) {
      developer.log("❌ LoginScreen: Authentication pipeline encountered an operational exception", error: e, stackTrace: stackTrace);
      
      if (mounted) {
        setState(() => _loading = false);
        _showFeedbackSnackBar("An unexpected error occurred. Connection timed out.");
      }
    }
  }

  /// Dispatches the Google One Tap integration hook with a defensive view state container check [INDEX]
  void _handleGoogleSignIn() async {
    setState(() => _loading = true);
    try {
      await GoogleOneTap.signIn();
    } catch (e) {
      developer.log("❌ LoginScreen: Google login handshake failure: $e");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Private centralized utility method to paint consistent user feedback snacks safely [INDEX]
  void _showFeedbackSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Explicitly override the dispose hook to clean up text controllers and protect against native memory leaks [INDEX]
  @override
  void dispose() {
    _emailCtrl.dispose();
    developer.log("⚙️ LoginScreen: Text editing controller garbage collected successfully.");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: SingleChildScrollView( // Added to permanently solve keyboard overflow layout yellow bars [INDEX]
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.bolt, size: 80, color: Colors.cyanAccent),
              const SizedBox(height: 20),
              const Text("Enter MindSpark",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              if (_linkSent)
                const Text("Check your email!\nClick the magic link to enter.",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 18),
                    textAlign: TextAlign.center)
              else ...[
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress, // Optimizes hardware keyboard display structures [INDEX]
                  autofillHints: const [AutofillHints.email], // Boosts conversion rates via text auto-fills [INDEX]
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: Colors.white30),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator(color: Colors.cyanAccent)
                    : ElevatedButton(
                        onPressed: _sendLink,
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50)),
                        child: const Text("SEND MAGIC LINK")),
                const SizedBox(height: 30),
                const Text("OR", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.g_mobiledata, color: Colors.black, size: 30),
                  label: const Text("Continue with Google", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: _loading ? null : _handleGoogleSignIn, // Disables button while network operations are hot [INDEX]
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
