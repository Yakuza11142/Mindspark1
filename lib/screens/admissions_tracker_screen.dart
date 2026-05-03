import 'package:flutter/material.dart';
import '../widgets/portal_webview_launcher.dart';

class GlobalAdmissionsHub extends StatelessWidget {
  /// The data structure: {"Region Name": {"Portal Name": "URL"}}
  final Map<String, Map<String, String>> regionalData;
  final String title;

  const GlobalAdmissionsHub({
    super.key,
    required this.regionalData,
    this.title = "Global Admissions Portals",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Elite dark theme
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: regionalData.length,
        itemBuilder: (context, index) {
          String region = regionalData.keys.elementAt(index);
          Map<String, String> portals = regionalData[region]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Global Category Header (e.g., WEST AFRICA, NORTH AMERICA)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  region.toUpperCase(),
                  style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
              ),
              // Generate tiles for every portal in this region
              ...portals.entries.map((e) => _buildPortalTile(context, e.key, e.value)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPortalTile(BuildContext context, String name, String url) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.language, color: Colors.amber),
        title: Text(name, style: const TextStyle(color: Colors.white)),
        subtitle: Text(url, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PortalWebviewLauncher(uniName: name, url: url),
          ),
        ),
      ),
    );
  }
}
