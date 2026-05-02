import 'package:flutter/material.dart';

class MarkdownTableBuilder extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;

  const MarkdownTableBuilder({super.key, required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: DataTable(
        columns: headers.map((h) => DataColumn(label: Text(h, style: const TextStyle(color: Colors.cyan)))).toList(),
        rows: rows.map((row) => DataRow(cells: row.map((cell) => DataCell(Text(cell, style: const TextStyle(color: Colors.white)))).toList())).toList(),
      ),
    );
  }
}