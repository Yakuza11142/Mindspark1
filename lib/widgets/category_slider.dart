import 'package:flutter/material.dart';
import '../data/subject_library.dart';
import '../screens/subject_explorer_screen.dart';

class CategorySlider extends StatelessWidget {
  const CategorySlider({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = SubjectLibrary.getCategories();
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final cat = categories[i];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubjectExplorerScreen(category: cat))),
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(color: cat.color.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: cat.color.withOpacity(0.5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(cat.icon, color: cat.color, size: 40),
                  const SizedBox(height: 10),
                  Text(cat.name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}