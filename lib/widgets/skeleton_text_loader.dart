import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonTextLoader extends StatelessWidget {
  const SkeletonTextLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white10,
      highlightColor: Colors.white24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(5, (i) => Container(
          height: 15, width: i % 2 == 0 ? double.infinity : 200,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
        )),
      ),
    );
  }
}