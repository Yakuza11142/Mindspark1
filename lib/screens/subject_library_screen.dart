import 'package:flutter/material.dart';
import '../widgets/glass_container.dart';
import 'subject_detail_screen.dart';

class SubjectLibraryScreen extends StatefulWidget {
  const SubjectLibraryScreen({super.key});
  @override
  State<SubjectLibraryScreen> createState() => _SubjectLibraryScreenState();
}

class _SubjectLibraryScreenState extends State<SubjectLibraryScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, dynamic>> allSubjects =[
    {"title": "Physics", "icon": Icons.rocket_launch, "color": Colors.purple},
    {"title": "Mathematics", "icon": Icons.calculate, "color": Colors.blue},
    {"title": "Biology", "icon": Icons.biotech, "color": Colors.green},
    {"title": "Chemistry", "icon": Icons.science, "color": Colors.orange},
    {"title": "History", "icon": Icons.account_balance, "color": Colors.brown},
    {"title": "Computer Science", "icon": Icons.computer, "color": Colors.cyan},
    {"title": "Economics", "icon": Icons.trending_up, "color": Colors.teal},
    {"title": "Literature", "icon": Icons.book, "color": Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter logic for the search bar
    var filteredSubjects = allSubjects.where((s) => s['title'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("Subject Library"), backgroundColor: Colors.transparent, elevation: 0),
      body: Column(
        children:[
          // THE LIBRARY SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GlassContainer(
              height: 60,
              child: TextField(
                controller: _searchCtrl,
                style: const TextStyle(color: Colors.white),
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: "Search for a subject...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                  suffixIcon: _searchQuery.isNotEmpty 
                    ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() { _searchCtrl.clear(); _searchQuery = ""; }))
                    : null,
                ),
              ),
            ),
          ),

          // THE SUBJECT GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
              itemCount: filteredSubjects.length,
              itemBuilder: (ctx, i) {
                var sub = filteredSubjects[i];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubjectDetailScreen(subjectName: sub['title'], color: sub['color']))),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [sub['color'].withOpacity(0.6), sub['color'].withOpacity(0.2)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: sub['color'].withOpacity(0.5))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(sub['icon'], size: 50, color: Colors.white),
                        const SizedBox(height: 10),
                        Text(sub['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}