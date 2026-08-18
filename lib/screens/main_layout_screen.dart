import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Inside _MainLayoutScreenState build method:
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildNavItem(AppNavigationConfig.indexHome, CupertinoIcons.house, CupertinoIcons.house_fill, theme.colorScheme.primary, labelHome, navItemWidthWidth, indicatorBorderRadiusFactor),
    _buildNavItem(AppNavigationConfig.indexSubjects, CupertinoIcons.book, CupertinoIcons.book_fill, theme.colorScheme.secondary, labelSubjects, navItemWidthWidth, indicatorBorderRadiusFactor),
    _buildNavItem(AppNavigationConfig.indexVideos, CupertinoIcons.play_circle, CupertinoIcons.play_circle_fill, theme.colorScheme.error, labelVideos, navItemWidthWidth, indicatorBorderRadiusFactor),
    _buildNavItem(AppNavigationConfig.indexSparkAi, CupertinoIcons.sparkles, CupertinoIcons.sparkles, theme.colorScheme.tertiary, labelSparkAi, navItemWidthWidth, indicatorBorderRadiusFactor),
    _buildNavItem(AppNavigationConfig.indexRank, CupertinoIcons.trophy, CupertinoIcons.trophy_fill, theme.colorScheme.inverseSurface, labelRank, navItemWidthWidth, indicatorBorderRadiusFactor),
    _buildNavItem(AppNavigationConfig.indexMe, CupertinoIcons.person, CupertinoIcons.person_fill, theme.colorScheme.onSurface, labelMe, navItemWidthWidth, indicatorBorderRadiusFactor),
  ],
)
