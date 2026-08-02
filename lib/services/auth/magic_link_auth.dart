import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'magic_link_upgrader.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final int _otpLength = 6;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _getOtpString() {
    return _controllers.map((c) => c.text).join();
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      // Advance focus forward if not at the final box
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _submitOtp(); // Auto-submit when the last box is filled
      }
    }
  }

  void _handleKeyEvent(int index, RawKeyEvent event) {
    // If user presses backspace on an empty box, jump focus backward
    if (event is RawKeyDownEvent && 
        event.logicalKey == LogicalKeyboardKey.backspace && 
        _controllers[index].text.isEmpty && 
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _submitOtp() async {
    final otpCode = _getOtpString();
    if (otpCode.length < _otpLength) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await MagicLinkUpgrader.verifyUpgradeOtp(
      email: widget.email,
      token: otpCode,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (success) {
      // Route out directly to your home panel or layout tree
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      setState(() => _errorMessage = 'Invalid or expired verification code. Try again.');
      // Clear inputs for clean retry state
      for (var controller in _controllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Enter the 6-digit confirmation code dispatched to:',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              widget.email,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 32),
            
            // 6 Individual input digits lined up horizontally
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_otpLength, (index) {
                return SizedBox(
                  width: 45,
                  child: RawKeyboardListener(
                    focusNode: FocusNode(), // Throwaway node for raw key intercept
                    onKey: (event) => _handleKeyEvent(index, event),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => _onOtpChanged(index, value),
                    ),
                  ),
                );
              }),
            ),
            
            if (_errorMessage != null) ...[
              const SizedBox(height: 20),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            
            const Spacer(),
            
            ElevatedButton(
              onPressed: _isLoading || _getOtpString().length < _otpLength ? null : _submitOtp,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading 
                  ? const CircularProgressIndicator() 
                  : const Text('Verify & Upgrade Account'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
