import 'package:flutter/material.dart';
import '../services/pdf_exporter.dart';

class ExportButton extends StatelessWidget {
  final String topic, content;
  const ExportButton({super.key, required this.topic, required this.content});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
      onPressed: () => PdfExporter.exportLesson(topic, content),
    );
  }
}