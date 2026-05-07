import 'package:flutter/material.dart';
import '../services/fcm_service.dart';

class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Stay Smart 🧠"),
      content: const Text("Allow notifications to get daily 3D facts and exam tips."),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
        ElevatedButton(
          onPressed: () {
            FcmService.init();
            Navigator.pop(context);
          },
          child: const Text("Allow"),
        )
      ],
    );
  }
}import 'package:flutter/material.dart';
import '../services/fcm_service.dart';

class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Stay Smart 🧠"),
      content: const Text("Allow notifications to get daily 3D facts and exam tips."),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
        ElevatedButton(
          onPressed: () {
            FcmService.init();
            Navigator.pop(context);
          },
          child: const Text("Allow"),
        )
      ],
    );
  }
}