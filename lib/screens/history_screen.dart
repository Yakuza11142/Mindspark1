import 'package:flutter/material.dart';
import '../services/history_engine.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    var data = await HistoryEngine.getHistory();
    setState(() => history = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam History")),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (ctx, i) {
          var h = history[i];
          return ListTile(
            title: Text(h['exam']),
            subtitle: Text(h['date']),
            trailing: Text("${h['score']}%", style: TextStyle(color: h['score'] > 50 ? Colors.green : Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}