import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfWatermarkEngine {
  static pw.Widget buildWatermark(String userId) {
    return pw.Transform.rotate(
      angle: -0.5,
      child: pw.Opacity(
        opacity: 0.1,
        child: pw.Text("LICENSED TO: $userId", style: pw.TextStyle(fontSize: 60, color: PdfColors.grey)),
      ),
    );
  }
}