import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  // Navigation tab indices defined directly inside the file
  static const int indexHome = 0;
  static const int indexSubjects = 1;
  static const int indexVideos = 2;
  static const int indexSparkAi = 3;
  static const int indexRank = 4;
  static const int indexMe = 5;

  int _currentIndex = indexHome;

  Widget _buildNavItem(
    int index,
    IconData unselectedIcon,
    IconData selectedIcon,
    Color activeColor,
    String label,
    double width,
    double borderRadius,
  ) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: isSelected ? activeColor.withOpacity(0.15) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected ? activeColor : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? activeColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double navItemWidthWidth = 60.0;
    const double indicatorBorderRadiusFactor = 12.0;

    const String labelHome = "Home";
    const String labelSubjects = "Subjects";
    const String labelVideos = "Videos";
    const String labelSparkAi = "Spark AI";
    const String labelRank = "Rank";
    const String labelMe = "Me";

    return Scaffold(
      body: Center(
        child: Text("Active Tab Index: $_currentIndex"),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: theme.scaffoldBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                indexHome,
                CupertinoIcons.house,
                CupertinoIcons.house_fill,
                theme.colorScheme.primary,
                labelHome,
                navItemWidthWidth,
                indicatorBorderRadiusFactor,
              ),
              _buildNavItem(
                indexSubjects,
                CupertinoIcons.book,
                CupertinoIcons.book_fill,
                theme.colorScheme.secondary,
                labelSubjects,
                navItemWidthWidth,
                indicatorBorderRadiusFactor,
              ),
              _buildNavItem(
                indexVideos,
                CupertinoIcons.play_circle,
                CupertinoIcons.play_circle_fill,
                theme.colorScheme.error,
                labelVideos,
                navItemWidthWidth,
                indicatorBorderRadiusFactor,
              ),
              _buildNavItem(
                indexSparkAi,
                CupertinoIcons.sparkles,
                CupertinoIcons.sparkles,
                theme.colorScheme.tertiary,
                labelSparkAi,
                navItemWidthWidth,
                indicatorBorderRadiusFactor,
              ),
              _buildNavItem(
                indexRank,
                CupertinoIcons.star,
                CupertinoIcons.star_fill,
                theme.colorScheme.inverseSurface,
                labelRank,
                navItemWidthWidth,
                indicatorBorderRadiusFactor,
              ),
              _buildNavItem(
                indexMe,
                CupertinoIcons.person,
                CupertinoIcons.person_fill,
                theme.colorScheme.onSurface,
                labelMe,
                navItemWidthWidth,
                indicatorBorderRadiusFactor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
