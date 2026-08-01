import 'dart:io';
import 'package:flutter/services.dart'; 
import 'package:intl/intl.dart'; 
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:developer' as developer;

class EliteCertificateService {
  /// Renders a certified high-fidelity document blueprint and dispatches an intent sheet safely
  static Future<void> createAndShare({
    required String studentName,
    required String practicalName,
  }) async {
    developer.log("🎓 Certificate Service: Compiling digital achievement manifest for student: $studentName");
    
    final pw.Document pdf = pw.Document();
    final String autoDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    pw.Font fontData;
    try {
      final ByteData rawData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
      fontData = pw.Font.ttf(rawData);
    } catch (_) {
      fontData = pw.Font.helvetica();
    }

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) =>
          _buildImageStyleLayout(studentName.trim(), practicalName.trim(), autoDate, fontData),
    ));

    try {
      final Directory dir = await getTemporaryDirectory();
      final String targetPath = '${dir.path}/MindSpark_Elite_Diploma_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final File file = File(targetPath);
      
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "I just mastered $practicalName! 🎓",
      );
    } catch (e, stack) {
      developer.log("❌ Certificate Service: PDF storage or sharing pipeline collapsed seamlessly", error: e, stackTrace: stack);
    }
  }

  static pw.Widget _buildImageStyleLayout(
      String name, String practical, String date, pw.Font globalFont) {
    
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.blue900, width: 15),
      ),
      child: pw.Container(
        margin: const pw.EdgeInsets.all(4),
        decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.amber700, width: 2)),
        child: pw.Stack(
          children: [
            pw.Positioned(top: 10, left: 10, child: _floralCorner(globalFont)),
            pw.Positioned(
                top: 10,
                right: 10,
                child: pw.Transform.rotate(angle: 1.57, child: _floralCorner(globalFont))),
            pw.Positioned(
                bottom: 10,
                left: 10,
                child: pw.Transform.rotate(angle: -1.57, child: _floralCorner(globalFont))),
            pw.Positioned(
                bottom: 10,
                right: 10,
                child: pw.Transform.rotate(angle: 3.14, child: _floralCorner(globalFont))),

            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 60, vertical: 30),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text("MIND SPARK ACADEMY",
                      style: pw.TextStyle(
                          font: globalFont,
                          fontSize: 32,
                          color: PdfColors.amber800,
                          fontWeight: pw.FontWeight.bold,
                          letterSpacing: 2)),
                  pw.Text("CERTIFICATE OF MASTERED COMPLETION",
                      style: pw.TextStyle(
                          font: globalFont,
                          fontSize: 18,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold)),

                  pw.SizedBox(height: 30),
                  pw.Text("This serves to certify that $name",
                      style: pw.TextStyle(font: globalFont, fontSize: 16)),
                  pw.SizedBox(height: 10),
                  pw.Text("MASTERED THE PRACTICAL:",
                      style: pw.TextStyle(
                          font: globalFont,
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900)),
                  pw.Text("[$practical]",
                      style: pw.TextStyle(
                          font: globalFont,
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900)),

                  pw.SizedBox(height: 15),
                  pw.Text("Issued by Mind Spark AI Academy on $date",
                      style: pw.TextStyle(font: globalFont, fontSize: 14)), 

                  pw.Spacer(),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      _signatureBlock("THE FOUNDER", "Mind Spark AI Lab", globalFont),
                      _goldEmbossedSeal(globalFont),
                      _qrPlaceholder(globalFont),
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

  static pw.Widget _floralCorner(pw.Font font) => pw.Text("❧",
      style: pw.TextStyle(font: font, fontSize: 40, color: PdfColors.amber700));

  static pw.Widget _goldEmbossedSeal(pw.Font font) {
    return pw.Container(
      width: 90,
      height: 90,
      decoration: const pw.BoxDecoration(
          color: PdfColors.amber, shape: pw.BoxShape.circle),
      child: pw.Center(
        child: pw.Text("SEAL OF\nEXCELLENCE",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
                font: font,
                color: PdfColors.white,
                fontSize: 8,
                fontWeight: pw.FontWeight.bold)),
      ),
    );
  }

  static pw.Widget _signatureBlock(String label, String value, pw.Font font) {
    return pw.Column(children: [
      pw.Text(value,
          style: pw.TextStyle(
              font: font,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold)),
      pw.Container(
          height: 1,
          width: 140,
          color: PdfColors.black,
          margin: const pw.EdgeInsets.symmetric(vertical: 5)),
      pw.Text(label, style: pw.TextStyle(font: font, fontSize: 10)),
    ]);
  }

  static pw.Widget _qrPlaceholder(pw.Font font) {
    return pw.Container(
      width: 60,
      height: 60,
      decoration:
          pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
      child: pw.Center(
          child: pw.Text("QR",
              style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey))),
    );
  }
}
