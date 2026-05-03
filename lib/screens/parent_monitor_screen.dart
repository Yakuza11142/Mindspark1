import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParentMonitorScreen extends StatelessWidget {
  const ParentMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parent Dashboard"), backgroundColor: Colors.indigo),
      body: FutureBuilder(
        future: Supabase.instance.client.from('parent_monitoring_dashboard').select(),
        builder: (ctx, AsyncSnapshot<List<dynamic>> snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          if (snap.data!.isEmpty) return const Center(child: Text("No children linked yet."));

          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (ctx, i) {
              var child = snap.data![i];
              return Card(
                color: Colors.white10,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.face, color: Colors.cyanAccent),
                  title: Text(child['child_name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text("XP: ${child['total_xp']} | Sparks: ${child['sparks']} \nExams Taken: ${child['total_exams_taken']}", style: const TextStyle(color: Colors.white70)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}