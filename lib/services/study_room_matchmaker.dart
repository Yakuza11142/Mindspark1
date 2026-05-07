import 'package:intl/intl.dart';

class StudyRoomMatchmaker {
  /// [activeCount] should be passed from your backend/stream
  /// [maxCapacity] defines the upper limit for the session
  static String findLobby({
    required String subject,
    required int activeCount,
    int maxCapacity = 100,
  }) {
    // Dynamically gets the current day (Monday, Tuesday, etc.)
    final String currentDay = DateFormat('EEEE').format(DateTime.now());

    return "Matched with $activeCount others studying $subject this $currentDay. "
           "Session Status: $activeCount/$maxCapacity. Connecting...";
  }
}
