import 'package:flutter/material.dart';
import '../services/watch_to_unlock_service.dart';
import '../services/ad_manager.dart'; // From Script 9
import 'package:provider/provider.dart';

class WatchToUnlockScreen extends StatefulWidget {
  const WatchToUnlockScreen({super.key});

  @override
  State<WatchToUnlockScreen> createState() => _WatchToUnlockScreenState();
}

class _WatchToUnlockScreenState extends State<WatchToUnlockScreen> {
  int adsWatched = 0;
  bool isLoading = false;

  void _watchAd() {
    setState(() => isLoading = true);
    
    // Trigger Google AdMob Rewarded Video
    context.read<AdManager>().showRewarded(() async {
      int status = await WatchToUnlockService.addAdWatch();
      
      if (status == -1) {
        // Unlocked!
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ 24 HOURS PRO UNLOCKED!"), backgroundColor: Colors.green));
          Navigator.pop(context); // Go back to home
        }
      } else {
        // Still needs more ads
        setState(() { adsWatched = status; isLoading = false; });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("Unlock For Free 🎁"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.play_circle_filled, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text("Get 24 Hours of Pro", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Can't pay? No problem. Watch 3 short videos to unlock GPT-4, Vedic Math, and X-Ray Vision for 24 hours.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            
            // PROGRESS BAR
            LinearProgressIndicator(
              value: adsWatched / 3,
              minHeight: 15,
              backgroundColor: Colors.white10,
              color: Colors.cyanAccent,
            ),
            const SizedBox(height: 10),
            Text("Videos Watched: $adsWatched / 3", style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
            
            const SizedBox(height: 40),
            isLoading 
              ? const CircularProgressIndicator(color: Colors.redAccent)
              : ElevatedButton.icon(
                  onPressed: _watchAd,
                  icon: const Icon(Icons.ondemand_video, color: Colors.white),
                  label: const Text("WATCH VIDEO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900], padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                )
          ],
        ),
      ),
    );
  }
}