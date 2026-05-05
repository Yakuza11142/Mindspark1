import 'dart:io';
import 'package:intl/intl.dart'; // Add this for automatic date formatting
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class EliteCertificateService {
  
  static Future<void> createAndShare({
    required String studentName,
    required String practicalName,
  }) async {
    final pdf = pw.Document();
    
    // Automatically gets the current date (e.g., May 05, 2026)
    final String autoDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) => _buildImageStyleLayout(studentName, practicalName, autoDate),
    ));

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/MindSpark_Elite_Diploma.pdf');
    await file.writeAsBytes(await pdf.save());
    
    await Share.shareXFiles([XFile(file.path)], text: "I just mastered $practicalName! 🎓");
  }

  static pw.Widget _buildImageStyleLayout(String name, String practical, String date) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.blue900, width: 15),
      ),
      child: pw.Container(
        margin: const pw.EdgeInsets.all(4),
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.amber700, width: 2)),
        child: pw.Stack(
          children: [
            // Decorative Floral Corners
            pw.Positioned(top: 10, left: 10, child: _floralCorner()),
            pw.Positioned(top: 10, right: 10, child: pw.Transform.rotate(angle: 1.57, child: _floralCorner())),
            pw.Positioned(bottom: 10, left: 10, child: pw.Transform.rotate(angle: -1.57, child: _floralCorner())),
            pw.Positioned(bottom: 10, right: 10, child: pw.Transform.rotate(angle: 3.14, child: _floralCorner())),

            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 60, vertical: 30),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text("MINDSPARK ELITE ACADEMY", 
                      style: pw.TextStyle(fontSize: 32, color: PdfColors.amber800, fontWeight: pw.FontWeight.bold, letterSpacing: 2)),
                  pw.Text("CERTIFICATE OF MASTERED COMPLETION", 
                      style: pw.TextStyle(fontSize: 18, color: PdfColors.black, fontWeight: pw.FontWeight.bold)),
                  
                  pw.SizedBox(height: 30),
                  pw.Text("This serves to certify that $name", style: pw.TextStyle(fontSize: 16)),
                  pw.SizedBox(height: 10),
                  pw.Text("MASTERED THE PRACTICAL:", 
                      style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                  pw.Text("[$practical]", 
                      style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                  
                  pw.SizedBox(height: 15),
                  pw.Text("Issued by Mind Spark AI Academy on $date", style: const pw.TextStyle(fontSize: 14)), // Auto-date displays here
                  
                  pw.Spacer(),
                  
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      _signatureBlock("THE FOUNDER"),
                      _goldEmbossedSeal(),
                      _qrPlaceholder(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _floralCorner() => pw.Text("❧", style: pw.TextStyle(fontSize: 40, color: PdfColors.amber700));

  static pw.Widget _goldEmbossedSeal() {
    return pw.Container(
      width: 90, height: 90,
      decoration: const pw.BoxDecoration(color: PdfColors.amber, shape: pw.BoxShape.circle),
      child: pw.Center(
        child: pw.Text("SEAL OF\nEXCELLENCE", textAlign: pw.TextAlign.center, 
            style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold)),
      ),
    );
  }

  static pw.Widget _signatureBlock(String label, String value) {
    return pw.Column(children: [
      pw.Text(value, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic)),
      pw.Container(height: 1, width: 140, color: PdfColors.black, margin: const pw.EdgeInsets.symmetric(vertical: 5)),
      pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
    ]);
  }

  static pw.Widget _qrPlaceholder() {
    return pw.Container(
      width: 60, height: 60,
      decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
      child: pw.Center(child: pw.Text("QR", style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey))),
    );
  }
}
