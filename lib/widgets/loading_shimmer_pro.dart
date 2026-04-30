import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerPro extends StatelessWidget {
  const LoadingShimmerPro({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[800]!,
      period: const Duration(milliseconds: 1500), // Slower shimmer saves CPU cycles
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}