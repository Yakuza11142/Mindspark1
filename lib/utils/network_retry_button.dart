import 'package:flutter/material.dart';

class NetworkRetryButton extends StatefulWidget {
  final Future<void> Function() onRetry;

  const NetworkRetryButton({super.key, required this.onRetry});

  @override
  State<NetworkRetryButton> createState() => _NetworkRetryButtonState();
}

class _NetworkRetryButtonState extends State<NetworkRetryButton> {
  // 1. Initialized safely within the state lifecycle so it survives parent widget rebuilds
  late final ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    // 2. CRUCIAL: Frees up internal device memory streams when the button unmounts
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoading,
      builder: (context, loading, _) {
        return ElevatedButton.icon(
          icon: loading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black87,
                  ),
                )
              : const Icon(Icons.refresh, color: Colors.black87),
          label: Text(
            loading ? "Retrying..." : "Retry Connection",
            style: const TextStyle(
              color: Colors.black87, 
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00E5FF),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: loading
              ? null
              : () async {
                  _isLoading.value = true;
                  try {
                    await widget.onRetry(); // Calls the function safe from context tracking
                  } finally {
                    // Check mounted state before updating to avoid tracking errors on quick page pops
                    if (mounted) {
                      _isLoading.value = false;
                    }
                  }
                },
        );
      },
    );
  }
}
