class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  // NOW WE HAVE 6 TABS (Nothing replaced, only added)
  final List<Widget> _pages =[
    const HomeTab(),             
    const SubjectLibraryScreen(),
    const VideoHubScreen(),      // NEW: Added Video Hub
    const SparkChatScreen(),     
    const LeaderboardScreen(),   
    const ProfileScreen(),       
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          const AdBannerWidget(),
          NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) => setState(() => _currentIndex = index),
            backgroundColor: const Color(0xFF0F172A),
            indicatorColor: Colors.cyanAccent.withOpacity(0.2),
            // Set labelBehavior to always show labels so 6 icons don't look crowded
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow, 
            destinations: const[
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: Colors.cyanAccent), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book, color: Colors.amber), label: 'Subjects'),
              // THE NEW VIDEO HUB BUTTON
              NavigationDestination(icon: Icon(Icons.play_circle_outline), selectedIcon: Icon(Icons.play_circle, color: Colors.redAccent), label: 'Videos'),
              NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome, color: Colors.purpleAccent), label: 'Spark AI'),
              NavigationDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events, color: Colors.orange), label: 'Rank'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: Colors.white), label: 'Me'),
            ],
          ),
        ],
      ),
    );
  }
}
