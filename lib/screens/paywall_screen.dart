import 'package:flutter/material.dart';
import '../services/payment_service.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => PaymentService().buyPro(),
          child: const Text("Subscribe \$9.99"),
        ),
      ),
    );
  }
}