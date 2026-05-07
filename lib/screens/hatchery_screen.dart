import 'package:flutter/material.dart';
import '../engines/infinite_pet_generator.dart';

class HatcheryScreen extends StatefulWidget {
  const HatcheryScreen({super.key});
  @override
  State<HatcheryScreen> createState() => _HatcheryScreenState();
}

class _HatcheryScreenState extends State<HatcheryScreen> {
  final TextEditingController _ctrl = TextEditingController();
  String? petImageUrl;
  bool isHatching = false;

  void _hatch() async {
    setState(() => isHatching = true);
    String? url = await InfinitePetGenerator.hatchEgg(_ctrl.text);
    setState(() { petImageUrl = url; isHatching = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("The Spark Hatchery 🥚")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              if (petImageUrl != null) 
                Image.network(petImageUrl!, height: 300)
              else if (isHatching)
                const CircularProgressIndicator(color: Colors.amber)
              else
                const Icon(Icons.egg, size: 100, color: Colors.white54),
              
              const SizedBox(height: 30),
              TextField(
                controller: _ctrl,
                decoration: const InputDecoration(hintText: "Describe your dream study pet... (e.g. Robot Tiger)"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _hatch, child: const Text("HATCH PET (Costs 1000 ⚡)"))
            ],
          ),
        ),
      ),
    );
  }
}