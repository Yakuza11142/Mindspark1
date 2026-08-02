import 'io_conditional.dart'; // Safe multiplatform import helper
import 'package:flutter/material.dart';
import 'native_google_auth.dart';
import 'native_apple_auth.dart';

class SocialAuthButtons extends StatefulWidget {
  final VoidCallback onSuccess;

  const SocialAuthButtons({super.key, required this.onSuccess});

  @override
  State<SocialAuthButtons> createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends State<SocialAuthButtons> {
  bool _isLoading = false;

  void _setLoading(bool loading) {
    if (mounted) {
      setState(() => _isLoading = loading);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = AppPlatform.isIOS;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Native Google Sign-In Button
        ElevatedButton(
          onPressed: _isLoading ? null : () async {
            final success = await NativeGoogleAuth.signInOrLinkWithGoogle(
              onLoadingChanged: _setLoading,
            );
            if (success) widget.onSuccess();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 1,
          ),
          child: _isLoading
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, size: 30, color: Colors.blue), // Replace with asset image if available
                    SizedBox(width: 8),
                    Text('Continue with Google', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
        ),

        // 2. Native Apple Sign-In Button (iOS Exclusive)
        if (isIOS) ...[
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _isLoading ? null : () async {
              final success = await NativeAppleAuth.signInOrLinkWithApple(
                onLoadingChanged: _setLoading,
              );
              if (success) widget.onSuccess();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: _isLoading
                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.apple, size: 24),
                      SizedBox(width: 8),
                      Text('Sign in with Apple', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
          ),
        ],
      ],
    );
  }
}
