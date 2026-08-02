import 'package:flutter/material.dart';

class XpLevelBadge extends StatelessWidget {
  final int level;
  
  const XpLevelBadge({
    super.key, 
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    // Explicit sizing prevents layout bugs in Rows, Columns, and ListViews
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: CircleAvatar(
        backgroundColor: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "$level",
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
