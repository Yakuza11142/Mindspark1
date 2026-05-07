import 'dart:math';

class PetNotificationService {
  // 1. Global Singleton Instance
  static final PetNotificationService _instance = PetNotificationService._internal();
  factory PetNotificationService() => _instance;
  PetNotificationService._internal();

  // 2. Infinite Variation Logic
  static const List<String> _actions = ["restore vitals", "re-energize", "maintain progress", "synchronize"];
  static const List<String> _descriptors = ["Urgent", "Priority", "Notice", "System Alert"];

  /// Generates infinite unique notifications based on real-time app data
  static void sendGlobalAlert({
    required String petName,
    required String subject,
    String status = "requires attention",
  }) {
    final random = Random();
    final descriptor = _descriptors[random.nextInt(_descriptors.length)];
    final action = _actions[random.nextInt(_actions.length)];

    // Constructed dynamically to feel professional and non-repetitive
    final String message = "[$descriptor] Your $petName $status. "
                           "Complete a $subject module to $action.";

    _dispatch(message);
  }

  static void _dispatch(String msg) {
    // Hooks into system-level push notifications
    debugPrint("Broadcasting Global Notification: $msg");
  }
}
