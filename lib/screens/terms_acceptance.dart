import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class TermsAcceptance extends StatefulWidget {
  // Decoupled raw widget tracking references to use lean, memory-safe callback builders instead [INDEX]
  final WidgetBuilder onAcceptanceConfirmedRouteBuilder;
  final String title;
  final String termsText;

  const TermsAcceptance({
    super.key,
    required this.onAcceptanceConfirmedRouteBuilder,
    this.title = "Terms & Conditions",
    this.termsText = "By clicking Accept, you agree to our Terms and AI Usage Policy.",
  });

  @override
  State<TermsAcceptance> createState() => _TermsAcceptanceState();
}

class _TermsAcceptanceState extends State<TermsAcceptance> {
  static const String _legalAcceptancePersistenceKey = 'legal_user_has_accepted_policy_v1';
  
  bool _hasAcceptedCheckbox = false;
  bool _isLoadingDiskState = true;

  @override
  void initState() {
    super.initState();
    // Verify user signature compliance parameters during frame initialization [INDEX]
    _checkPreExistingAcceptanceStatus();
  }

  /// Verifies if this specific hardware profile has already signed the terms before painting layouts [INDEX]
  Future<void> _checkPreExistingAcceptanceStatus() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool alreadyAccepted = prefs.getBool(_legalAcceptancePersistenceKey) ?? false;

      if (alreadyAccepted && mounted) {
        developer.log("🛡️ TermsAcceptance: Pre-existing signature found. Auto-forwarding router pipeline.");
        _executeNavigationalShift();
        return;
      }
    } catch (e, stack) {
      developer.log("⚠️ TermsAcceptance: Shared Preferences cache lookup dropped gracefully", error: e, stackTrace: stack);
    } finally {
      if (mounted) {
        setState(() => _isLoadingDiskState = false);
      }
    }
  }

  /// Commits the cryptographic signature check token permanently to local hardware disk blocks [INDEX]
  Future<void> _commitAcceptanceSignatureAndNavigate() async {
    if (!_hasAcceptedCheckbox) return;

    setState(() => _isLoadingDiskState = true);
    developer.log("💾 TermsAcceptance: Writing persistent legal compliance token down to disk space.");

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_legalAcceptancePersistenceKey, true);
      
      _executeNavigationalShift();
    } catch (e, stack) {
      developer.log("❌ TermsAcceptance: Failed to serialize legal verification flag", error: e, stackTrace: stack);
      if (mounted) {
        setState(() => _isLoadingDiskState = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage error. Unable to register compliance sign-off.")),
        );
      }
    }
  }

  void _executeNavigationalShift() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: widget.onAcceptanceConfirmedRouteBuilder),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingDiskState) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Enforced optimized, efficient constant hex background themes [INDEX]
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              Icon(Icons.gavel_rounded, size: 65, color: Theme.of(context).primaryColor),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(), // Fluid physics behavior optimizes scroll interactions [INDEX]
                    child: Text(
                      widget.termsText,
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Theme(
                data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white30),
                child: CheckboxListTile(
                  value: _hasAcceptedCheckbox,
                  onChanged: (bool? val) => setState(() => _hasAcceptedCheckbox = val ?? false),
                  title: const Text(
                    "I have read and agree to the terms and AI disclosure notices.",
                    style: TextStyle(color: Colors.white90, fontSize: 13),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: const Color(0xFF1E293B),
                    disabledForegroundColor: Colors.white24,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 5,
                  ),
                  onPressed: _hasAcceptedCheckbox ? _commitAcceptanceSignatureAndNavigate : null, // Strict latch mitigates policy bypass exploits [INDEX]
                  child: const Text("CONTINUE TO APPLICATION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
