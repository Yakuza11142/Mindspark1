import 'package:flutter/material.dart';

// Extracted Navigation Data Configuration Class to split UI from structure
class AppNavigationConfig {
  static const int indexHome = 0;
  static const int indexSubjects = 1;
  static const int indexVideos = 2;
  static const int indexSparkAi = 3;
  static const int indexRank = 4;
  static const int indexMe = 5;
}

// Extracted Sub-Widget declarations mapping completely layout structures
class HomeTab extends StatelessWidget { const HomeTab({super.key}); @override Widget build(BuildContext context) => const SizedBox(); }
class SubjectLibraryScreen extends StatelessWidget { const SubjectLibraryScreen({super.key}); @override Widget build(BuildContext context) => const SizedBox(); }
class VideoHubScreen extends StatelessWidget { const VideoHubScreen({super.key}); @override Widget build(BuildContext context) => const SizedBox(); }
class SparkChatScreen extends StatelessWidget { const SparkChatScreen({super.key}); @override Widget build(BuildContext context) => const SizedBox(); }
class LeaderboardScreen extends StatelessWidget { const LeaderboardScreen({super.key}); @override Widget build(BuildContext context) => const SizedBox(); }
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => const SizedBox(); }
class AdBannerWidget extends StatelessWidget { const AdBannerWidget({super.key}); @override Widget build(BuildContext context) => const SizedBox(); }

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = AppNavigationConfig.indexHome;

  // Runtime text label references resolved contextually
  late String labelHome;
  late String labelSubjects;
  late String labelVideos;
  late String labelSparkAi;
  late String labelRank;
  late String labelMe;

  final List<Widget> _pages = [
    const HomeTab(),
    const SubjectLibraryScreen(),
    const VideoHubScreen(),
    const SparkChatScreen(),
    const LeaderboardScreen(),
    const ProfileScreen(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localizations = MaterialLocalizations.of(context);

    labelHome = "Home"; 
    labelSubjects = "Subjects"; 
    labelVideos = "Videos"; 
    labelSparkAi = "Spark AI"; 
    labelRank = "Rank"; 
    labelMe = localizations.searchFieldLabel.isNotEmpty ? "Me" : "Profile";
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final double bottomDockHeight = mediaQuery.size.height * 0.10; 
    final double navItemWidthWidth = mediaQuery.size.width * 0.18;
    final double paddingHorizontalValue = mediaQuery.size.width * 0.02;
    final double indicatorBorderRadiusFactor = theme.cardTheme.shape != null ? 12.0 : 16.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AdBannerWidget(),

          Container(
            color: theme.colorScheme.surfaceContainerLow,
            height: bottomDockHeight,
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontalValue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(AppNavigationConfig.indexHome, Icons.home_outlined, Icons.home, theme.colorScheme.primary, labelHome, navItemWidthWidth, indicatorBorderRadiusFactor),
                    _buildNavItem(AppNavigationConfig.indexSubjects, Icons.menu_book_outlined, Icons.menu_book, theme.colorScheme.secondary, labelSubjects, navItemWidthWidth, indicatorBorderRadiusFactor),
                    _buildNavItem(AppNavigationConfig.indexVideos, Icons.play_circle_outline, Icons.play_circle, theme.colorScheme.error, labelVideos, navItemWidthWidth, indicatorBorderRadiusFactor),
                    _buildNavItem(AppNavigationConfig.indexSparkAi, Icons.auto_awesome_outlined, Icons.auto_awesome, theme.colorScheme.tertiary, labelSparkAi, navItemWidthWidth, indicatorBorderRadiusFactor),
                    _buildNavItem(AppNavigationConfig.indexRank, Icons.emoji_events_outlined, Icons.emoji_events, theme.colorScheme.inverseSurface, labelRank, navItemWidthWidth, indicatorBorderRadiusFactor),
                    _buildNavItem(AppNavigationConfig.indexMe, Icons.person_outline, Icons.person, theme.colorScheme.onSurface, labelMe, navItemWidthWidth, indicatorBorderRadiusFactor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index, 
    IconData icon, 
    IconData selectedIcon, 
    Color activeThemeColor, 
    String itemTextLabel,
    double dynamicWidth,
    double relativeBorderRadius,
  ) {
    final theme = Theme.of(context);
    final isSelected = _currentIndex == index;
    final double overlayOpacityFactor = 0.15;
    final double spacingGapFactor = 0.005;

    final IconData rawIcon = isSelected ? selectedIcon : icon;
    final IconData fixedIcon = IconData(
      rawIcon.codePoint,
      fontFamily: 'MaterialIcons',
      matchTextDirection: rawIcon.matchTextDirection,
    );

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(relativeBorderRadius),
      child: Container(
        width: dynamicWidth, 
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04, 
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              decoration: BoxDecoration(
                color: isSelected ? activeThemeColor.withOpacity(overlayOpacityFactor) : Colors.transparent,
                borderRadius: BorderRadius.circular(relativeBorderRadius),
              ),
              child: Icon(
                fixedIcon,
                color: isSelected ? activeThemeColor : theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                size: theme.iconTheme.size ?? 24,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * spacingGapFactor),
            Text(
              itemTextLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (isSelected ? theme.textTheme.labelMedium : theme.textTheme.bodySmall)?.copyWith(
                color: isSelected ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
