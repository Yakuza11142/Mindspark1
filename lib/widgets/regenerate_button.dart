import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/currency_manager.dart';

class RegenerateButton extends StatelessWidget {
  final VoidCallback onForceNew;
  final String assetType; // e.g., "3D Model"
  
  const RegenerateButton({super.key, required this.onForceNew, required this.assetType});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purpleAccent.withOpacity(0.2),
        side: const BorderSide(color: Colors.purpleAccent),
      ),
      icon: const Icon(Icons.refresh, color: Colors.white),
      label: Text("Generate New $assetType (Costs 50 ⚡)", style: const TextStyle(color: Colors.white, fontSize: 12)),
      onPressed: () async {
        // CHARGE THE USER TO FORCE A NEW API CALL
        bool success = await context.read<CurrencyManager>().spendSparks(50);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Generating fresh asset...")));
          onForceNew(); // Triggers the HiveMindRouter with forceNewMovement = true
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not enough Sparks! Watch an Ad.", style: TextStyle(color: Colors.amber))));
        }
      },
    );
  }
}