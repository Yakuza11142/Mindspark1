import 'package:supabase_flutter/supabase_flutter.dart';

class BattleGame {
  final _supabase = Supabase.instance.client;
  late RealtimeChannel _channel;
  
  // Game State
  int myScore = 0;
  int opponentScore = 0;
  String? opponentName;

  void startMatch(String roomId, String myName, Function onUpdate) {
    _channel = _supabase.channel('room:$roomId');

    // 1. Sync scores via Broadcast (Low Latency)
    _channel.onBroadcast(
      event: 'score_update',
      callback: (payload) {
        if (payload['user'] != myName) {
          opponentScore = payload['score'];
          opponentName = payload['user'];
          onUpdate(); // Trigger UI Refresh
        }
      },
    ).subscribe();

    // 2. Track who is online via Presence
    _channel.onPresenceSync((payload) {
      print('Players in room: ${_channel.presenceState()}');
    }).subscribe((status, [error]) async {
      if (status == RealtimeSubscribeStatus.subscribed) {
        await _channel.track({'user': myName, 'online_at': DateTime.now().toIso8601String()});
      }
    });
  }

  void updateMyScore(int newScore, String myName) {
    myScore = newScore;
    // Broadcast my new score to the opponent instantly
    _channel.sendBroadcast(
      event: 'score_update',
      payload: {'user': myName, 'score': myScore},
    );
  }

  void leave() => _supabase.removeChannel(_channel);
}
class SupabaseBattleScreen extends StatefulWidget {
  final String roomId;
  final String userName;
  final List<QuizQuestion> questions;

  const SupabaseBattleScreen({super.key, required this.roomId, required this.userName, required this.questions});

  @override
  State<SupabaseBattleScreen> createState() => _SupabaseBattleScreenState();
}

class _SupabaseBattleScreenState extends State<SupabaseBattleScreen> {
  final BattleGame _game = BattleGame();
  int _qIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize matchmaking and real-time listeners
    _game.startMatch(widget.roomId, widget.userName, () => setState(() {}));
  }

  void _answer(int index) {
    if (index == widget.questions[_qIndex].correctIndex) {
      _game.updateMyScore(_game.myScore + 10, widget.userName);
    }
    // Infinite loop: cycles through questions automatically
    setState(() => _qIndex = (_qIndex + 1) % widget.questions.length);
  }

  @override
  void dispose() {
    _game.leave(); // Clean up channel to avoid leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_qIndex];
    return Scaffold(
      appBar: AppBar(title: Text("Battle: ${widget.roomId}")),
      body: Column(
        children: [
          _buildScoreBoard(),
          const Spacer(),
          Text(q.question, style: const TextStyle(fontSize: 22), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ...List.generate(q.options.length, (i) => 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () => _answer(i), child: Text(q.options[i])),
            )
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildScoreBoard() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("${widget.userName}: ${_game.myScore}", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          const Text("VS", style: TextStyle(fontSize: 18)),
          Text("${_game.opponentName ?? 'Waiting...'}: ${_game.opponentScore}", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
