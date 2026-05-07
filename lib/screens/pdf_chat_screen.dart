import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Add to pubspec
import '../engines/document_chat_engine.dart';
import '../services/pdf_text_extractor.dart';

class PdfChatScreen extends StatefulWidget {
  const PdfChatScreen({super.key});
  @override
  State<PdfChatScreen> createState() => _PdfChatScreenState();
}

class _PdfChatScreenState extends State<PdfChatScreen> {
  final DocumentChatEngine _engine = DocumentChatEngine();
  String status = "Upload a PDF Textbook or Past Question";
  bool isReady = false;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() => status = "Analyzing Document...");
      String text = await PdfTextExtractor.extractText(File(result.files.single.path!));
      _engine.loadDocument(text);
      setState(() { status = "Document Loaded. Ask me anything!"; isReady = true; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MindSpark Doc-Chat")),
      body: Column(
        children:[
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blueGrey.withOpacity(0.2),
            child: Row(
              children:[
                const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                const SizedBox(width: 10),
                Expanded(child: Text(status)),
                if (!isReady) ElevatedButton(onPressed: _pickFile, child: const Text("Upload"))
              ],
            ),
          ),
          const Expanded(child: Center(child: Text("Chat UI Goes Here"))),
        ],
      ),
    );
  }
}