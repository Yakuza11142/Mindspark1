import 'package:flutter/material.dart';
import '../config/supabase_core_config.dart';

class CeoRevenueTracker extends StatelessWidget {
  const CeoRevenueTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("LIVE COMMAND CENTER", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // This stream stays open infinitely, listening for any database changes
        stream: SupabaseCoreConfig.client.from('system_metrics').stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final metrics = snapshot.data!.first; // Always draws the latest row

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _metricTile("LIVE REVENUE", "₦${metrics['revenue']}", Colors.green),
                const SizedBox(height: 15),
                _metricTile("PRO SUBS", "${metrics['subs']}", Colors.cyan),
                const SizedBox(height: 15),
                _metricTile("AD IMPRESSIONS", "${metrics['ads']}", Colors.amber),
                const Spacer(),
                _buildActionGrid(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _metricTile(String label, String value, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 14)),
          Text(value, style: TextStyle(color: color, fontSize: 42, fontWeight: FontWeight.black)),
        ],
      ),
    );
  }

  Widget _buildActionGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        _controlBtn(Icons.refresh, "Sync", "force_sync"),
        _controlBtn(Icons.security, "Guard", "toggle_rls"),
        _controlBtn(Icons.bolt, "Turbo", "enable_cache"),
      ],
    );
  }

  Widget _controlBtn(IconData icon, String label, String action) {
    return InkWell(
      onTap: () => SupabaseCoreConfig.client.functions.invoke('system-control', body: {'action': action}),
      child: Column(
        children: [
          CircleAvatar(backgroundColor: Colors.white12, child: Icon(icon, color: Colors.white)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }
}
// supabase/functions/system-control/index.ts
import { createClient } from 'jsr:@supabase/supabase-js@2'

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.serve(async (req) => {
  try {
    const { action, payload } = await req.json()

    // Map actions to infinite database updates
    const operations: Record<string, any> = {
      'force_sync': () => supabase.rpc('calculate_global_revenue'),
      'toggle_maintenance': () => supabase.from('settings').update({ status: 'offline' }).eq('id', 1),
      'global_alert': () => supabase.from('notifications').insert({ message: payload?.msg }),
    }

    if (operations[action]) {
      await operations[action]()
    }

    return new Response(JSON.stringify({ status: "EXECUTED", timestamp: new Date() }), {
      headers: { "Content-Type": "application/json" }
    })
  } catch (e) {
    return new Response(JSON.stringify({ error: e.message }), { status: 500 })
  }
})
