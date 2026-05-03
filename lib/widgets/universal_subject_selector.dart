import 'package:flutter/material.dart';
import '../screens/universal_exam_slip_screen.dart';

class UniversalSubjectSelector extends StatefulWidget {
  final String examName;
  const UniversalSubjectSelector({super.key, required this.examName});

  @override
  State<UniversalSubjectSelector> createState() => _UniversalSubjectSelectorState();
}

class _UniversalSubjectSelectorState extends State<UniversalSubjectSelector> {
  final TextEditingController _ctrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  List<String> mySubjects =[];

  void _addSubject() {
    if (_ctrl.text.isNotEmpty) {
      setState(() { mySubjects.add(_ctrl.text.trim()); _ctrl.clear(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configure ${widget.examName}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:[
            TextField(controller: _nameCtrl, decoration: const InputDecoration(hintText: "Enter Full Name")),
            const SizedBox(height: 10),
            Row(
              children:[
                Expanded(child: TextField(controller: _ctrl, decoration: const InputDecoration(hintText: "Add a Subject (e.g. Further Math)"))),
                IconButton(icon: const Icon(Icons.add_circle, color: Colors.cyan), onPressed: _addSubject)
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mySubjects.length,
                itemBuilder: (ctx, i) => ListTile(title: Text(mySubjects[i]), trailing: const Icon(Icons.check, color: Colors.green)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => UniversalExamSlipScreen(
                  studentName: _nameCtrl.text.isEmpty ? "STUDENT" : _nameCtrl.text, 
                  examName: widget.examName, 
                  subjects: mySubjects
                )));
              },
              child: const Text("GENERATE EXAM SLIP")
            )
          ],
        ),
      ),
    );
  }
}