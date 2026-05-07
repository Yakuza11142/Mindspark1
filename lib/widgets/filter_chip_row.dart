import 'package:flutter/material.dart';

class FilterChipRow extends StatelessWidget {
  final Function(String) onFilterSelect;
  const FilterChipRow({super.key, required this.onFilterSelect});

  @override
  Widget build(BuildContext context) {
    List<String> filters =["All", "Science", "Arts", "Commercial", "Tech"];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ChoiceChip(
            label: Text(filters[i]),
            selected: i == 0,
            onSelected: (val) => onFilterSelect(filters[i]),
            selectedColor: Colors.cyanAccent.withOpacity(0.3),
            backgroundColor: Colors.white10,
          ),
        ),
      ),
    );
  }
}