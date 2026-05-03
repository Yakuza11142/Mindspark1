import 'package:flutter/material.dart';
import '../services/user_storage_limiter.dart';

class DataWipeUtility extends StatelessWidget {
  const DataWipeUtility({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.cleaning_services, color: Colors.orange),
      title: const Text("Clear App Cache"),
      subtitle: const Text("Frees up phone storage"),
      onTap: () async {
        await UserStorageLimiter.enforce100MbLimit();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cache Cleared. Space Restored.")));
      },
    );
  }
}