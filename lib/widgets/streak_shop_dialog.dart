import 'package:flutter/material.dart';
import '../services/currency_manager.dart';

void showStreakShop(BuildContext context, CurrencyManager currency) {
  showDialog(
    context: context, 
    builder: (ctx) => AlertDialog(
      title: const Text("Streak Shop"),
      content: ListTile(
        title: const Text("Freeze Streak (24h)"),
        trailing: const Text("500 ⚡"),
        onTap: () {
          currency.spendSparks(500);
          Navigator.pop(ctx);
        },
      ),
    )
  );
}