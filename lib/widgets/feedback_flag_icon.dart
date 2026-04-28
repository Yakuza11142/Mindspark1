import 'package:flutter/material.dart';
import '../services/report_bad_response_service.dart';

class FeedbackFlagIcon extends StatelessWidget {
  final String question;
  final String answer;

  const FeedbackFlagIcon({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.flag_outlined, color: Colors.grey, size: 16),
      onPressed: () {
        ReportBadResponseService.flagResponse(question, answer);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Thanks! Reported for improvement.")));
      },
    );
  }
}