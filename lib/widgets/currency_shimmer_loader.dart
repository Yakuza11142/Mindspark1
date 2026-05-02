import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CurrencyShimmerLoader extends StatelessWidget {
  const CurrencyShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white10,
      highlightColor: Colors.amber.withOpacity(0.5),
      child: Container(width: 150, height: 40, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5))),
    );
  }
}