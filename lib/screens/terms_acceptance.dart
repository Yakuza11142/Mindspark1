import 'package:flutter/material.dart';

class TermsAcceptance extends StatefulWidget {
  final Widget nextScreen;
  final String title;
  final String termsText;

  const TermsAcceptance({
    super.key,
    required this.nextScreen,
    this.title = "Terms & Conditions",
    this.termsText = "By clicking Accept, you agree to our Terms and AI Usage Policy.",
  });

  @override
  State<TermsAcceptance> createState() => _TermsAcceptanceState();
}

class _TermsAcceptanceState extends State<TermsAcceptance> {
  bool _hasAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Icon(Icons.gavel_rounded, size: 60, color: Theme.of(context).primaryColor),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.termsText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                ),
              ),
              const Divider(),
              CheckboxListTile(
                value: _hasAccepted,
                onChanged: (val) => setState(() => _hasAccepted = val ?? false),
                title: const Text("I have read and agree to the terms"),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _hasAccepted
                      ? () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => widget.nextScreen),
                          )
                      : null, // Button is disabled until checkbox is ticked
                  child: const Text("CONTINUE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
