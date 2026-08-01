import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class GroupStudyMatcher {
  // Singleton pattern enforces a single unified tracking footprint across all view ports
  GroupStudyMatcher._internal();
  static final GroupStudyMatcher instance = GroupStudyMatcher._internal();

  static final SupabaseClient _db = Supabase.instance.client;
  static RealtimeChannel? _presenceChannel;
  
  // Isolated stream controller broadcasting active lobby counts safely to UI states
  static final StreamController<int> _lobbyCountController = StreamController<int>.broadcast();
  static Stream<int> get lobbyCountStream => _lobbyCountController.stream;

  /// Joins a specific real-time subject lobby channel and safely streams player presence metrics
  static void joinSubjectLobby(String subject, String userId) {
    final String standardizedRoomKey = "lobby_${subject.trim().toLowerCase().replaceAll(' ', '_')}";
    
    leaveCurrentLobby();
    
    developer.log("📡 StudyMatcher: Initializing synchronized real-time presence channel for room: $standardizedRoomKey");

    try {
      // Capture an explicit local variable instance handle to immunize the background thread against asynchronous null mutations [INDEX]
      final RealtimeChannel activeChannel = _db.channel('realtime:$standardizedRoomKey');
      _presenceChannel = activeChannel;

      activeChannel.onPresenceSync((RealtimePresenceSyncEvent event) {
        // Re-mapped the container mapping definitions to match the package's true Map<String, List<dynamic>> internal scheme [INDEX]
        final Map<String, List<dynamic>> presenceState = Map<String, List<dynamic>>.from(activeChannel.presenceState());
        int totalActiveStudents = 0;
        
        presenceState.forEach((key, list) {
          totalActiveStudents += list.length;
        });

        _lobbyCountController.add(totalActiveStudents);
        developer.log("👥 StudyMatcher: Synchronized presence updated. Active students in $standardizedRoomKey: $totalActiveStudents");
      }).onPresenceJoin((RealtimePresenceJoinEvent event) {
        developer.log("👋 Student joined the study room circle.");
      }).onPresenceLeave((RealtimePresenceLeaveEvent event) {
        developer.log("🏃 Student left the study room circle.");
      });

      // Pass actions explicitly down the local reference scope
      activeChannel.subscribe((RealtimeChannelState status, Object? error) async {
        if (status == RealtimeChannelState.subscribed) {
          developer.log("✅ StudyMatcher: Channel track engaged. Broadcasting presence profile mapping.");
          try {
            // Executing tracks on our local channel reference completely eliminates background null check errors [INDEX]
            await activeChannel.track({
              'user_id': userId,
              'online_at': DateTime.now().toUtc().toIso8601String(),
            });
          } catch (trackError) {
            developer.log("⚠️ StudyMatcher: Late presence registration track failed or was aborted gracefully: $trackError");
          }
        }
      });
    } catch (e, stackTrace) {
      developer.log("❌ StudyMatcher: Concurrency mapping crashed during subscription initialization", error: e, stackTrace: stackTrace);
      _lobbyCountController.add(1); 
    }
  }

  /// Call this cleanup hook to drop active platform sockets cleanly when changing subjects or closing the layout
  static void leaveCurrentLobby() {
    if (_presenceChannel != null) {
      developer.log("⚙️ StudyMatcher: Unsubscribing and untracking active presence channel locks safely.");
      try {
        _db.removeChannel(_presenceChannel!);
      } catch (e) {
        developer.log("Error dropping channel connection safely: $e");
      }
      _presenceChannel = null;
    }
  }
}
