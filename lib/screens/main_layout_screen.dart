import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 1. IMPORT YOUR REAL SCREEN WIDGETS HERE
// Adjust these import paths to match your actual file locations:
import 'home_screen.dart';
import 'subjects_screen.dart';
import 'videos_screen.dart';
import 'spark_ai_screen.dart';
import 'rank_screen.dart';
import 'profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  static const int indexHome = 0;
  static const int indexSubjects = 1;
  static const int indexVideos = 2;
  static const int indexSparkAi = 3;
  static const int indexRank = 4;
  static const int indexMe = 5;

  int _currentIndex = indexHome;

  // 2. REPLACE _TabPlaceholder WITH YOUR REAL SCREEN CLASSES
  final List<Widget> _screens = const [
    HomeScreen(),
    SubjectsScreen(),
    VideosScreen(),
    SparkAIScreen(),
    RankScreen(),
    ProfileScreen(),
  ];

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
    const double navItemWidth = 60.0;
    const double indicatorBorderRadiusFactor = 12.0;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: theme.scaffoldBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(indexHome, CupertinoIcons.house, CupertinoIcons.house_fill, theme.colorScheme.primary, "Home", navItemWidth, indicatorBorderRadiusFactor),
              _buildNavItem(indexSubjects, CupertinoIcons.book, CupertinoIcons.book_fill, theme.colorScheme.secondary, "Subjects", navItemWidth, indicatorBorderRadiusFactor),
              _buildNavItem(indexVideos, CupertinoIcons.play_circle, CupertinoIcons.play_circle_fill, theme.colorScheme.error, "Videos", navItemWidth, indicatorBorderRadiusFactor),
              _buildNavItem(indexSparkAi, CupertinoIcons.sparkles, CupertinoIcons.sparkles, theme.colorScheme.tertiary, "Spark AI", navItemWidth, indicatorBorderRadiusFactor),
              _buildNavItem(indexRank, CupertinoIcons.star, CupertinoIcons.star_fill, theme.colorScheme.inverseSurface, "Rank", navItemWidth, indicatorBorderRadiusFactor),
              _buildNavItem(indexMe, CupertinoIcons.person, CupertinoIcons.person_fill, theme.colorScheme.onSurface, "Me", navItemWidth, indicatorBorderRadiusFactor),
            ],
          ),
        ),
      ),
    );
  }
}
