import 'dart:io';
import 'package:flutter/services.dart'; 
import 'package:intl/intl.dart'; 
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class EliteCertificateService {
  static Future<void> createAndShare({required String studentName, required String practicalName}) async {
    final pdf = pw.Document();
    final date = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    pw.Font font;
    try {
      font = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
    } catch (_) { font = pw.Font.helvetica(); }

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(0),
      build: (ctx) => _buildLayout(studentName.trim(), practicalName.trim(), date, font),
    ));

    try {
      final file = File('${(await getTemporaryDirectory()).path}/Diploma_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());
      await Share.shareXFiles([XFile(file.path)], text: "I just mastered $practicalName! 🎓");
    } catch (_) {}
  }

  static pw.Widget _buildLayout(String name, String practical, String date, pw.Font font) {
    const navy = PdfColor.fromInt(0xFF0F1A2C), gold = PdfColor.fromInt(0xFFD4AF37);
    return pw.Container(
      width: PdfPageFormat.a4.landscape.width,
      height: PdfPageFormat.a4.landscape.height,
      color: PdfColors.white,
      child: pw.Stack(
        children: [
          pw.Positioned.fill(child: pw.Container(margin: const pw.EdgeInsets.all(15), decoration: pw.BoxDecoration(border: pw.Border.all(color: navy, width: 14)))),
          pw.Positioned.fill(child: pw.Container(margin: const pw.EdgeInsets.all(34), decoration: pw.BoxDecoration(border: pw.Border.all(color: gold, width: 1.5)))),
          
          // COMPRESSED: Dynamic corner generation pass
          for (var t in [true, false]) for (var l in [true, false])
            pw.Positioned(top: t ? 25 : null, bottom: t ? null : 25, left: l ? 25 : null, right: l ? null : 25, child: _corner(t, l)),

          pw.Center(
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 90, vertical: 60),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.SizedBox(height: 25),
                  pw.Text("MIND SPARK", style: pw.TextStyle(font: font, fontSize: 28, color: const PdfColor.fromInt(0xFFB8860B), fontWeight: pw.FontWeight.bold, letterSpacing: 1.5)),
                  pw.Text("CERTIFICATE OF MASTERED COMPLETION", style: pw.TextStyle(font: font, fontSize: 13, color: PdfColors.grey700, letterSpacing: 1, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 35),
                  pw.Text("This serves to certify that $name", style: pw.TextStyle(font: font, fontSize: 16, fontStyle: pw.FontStyle.italic)),
                  pw.SizedBox(height: 12),
                  pw.Text("MASTERED THE PRACTICAL:", style: pw.TextStyle(font: font, fontSize: 20, fontWeight: pw.FontWeight.bold, color: navy)),
                  pw.Text("[$practical]", style: pw.TextStyle(font: font, fontSize: 26, fontWeight: pw.FontWeight.bold, color: navy)),
                  pw.SizedBox(height: 20),
                  pw.Text("Issued by Mind Spark on $date", style: pw.TextStyle(font: font, fontSize: 13, color: PdfColors.grey600)),
                  pw.Spacer(),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      _sig("Lead Architect\nYakuza11142", "Yakuza11142", font),
                      _seal(font),
                      _sig("The Founder", "Academy Director", font),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),
          ),
          pw.Positioned(bottom: 60, right: 65, child: _qr()),
        ],
      ),
    );
  }

  static pw.Widget _corner(bool top, bool left) => pw.CustomPaint(
    size: const PdfPoint(40, 40),
    painter: (canvas, size) {
      canvas..setStrokeColor(const PdfColor.fromInt(0xFFD4AF37))..setLineWidth(2)..moveTo(left ? 0 : 40, top ? 40 : 0)..lineTo(left ? 40 : 0, top ? 40 : 0)..lineTo(left ? 40 : 0, top ? 0 : 40)..stroke()
            ..setStrokeColor(const PdfColor.fromInt(0xFF0F1A2C))..setLineWidth(4)..moveTo(left ? 8 : 32, top ? 32 : 8)..lineTo(left ? 32 : 8, top ? 32 : 8)..lineTo(left ? 32 : 8, top ? 8 : 32)..stroke();
    },
  );

  static pw.Widget _seal(pw.Font font) => pw.Container(
    width: 75, height: 75, decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFFD4AF37), shape: pw.BoxShape.circle),
    child: pw.Center(child: pw.Container(width: 67, height: 67, decoration: pw.BoxDecoration(shape: pw.BoxShape.circle, border: pw.Border.all(color: PdfColors.white, style: pw.BorderStyle.dashed)),
      child: pw.Center(child: pw.Text("SEAL OF\nEXCELLENCE", textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font, color: PdfColors.white, fontSize: 7, fontWeight: pw.FontWeight.bold, letterSpacing: 0.5))))),
  );

  static pw.Widget _sig(String title, String name, pw.Font font) => pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    children: [
      pw.Text(name, style: pw.TextStyle(font: font, fontSize: 13, fontStyle: pw.FontStyle.italic, color: const PdfColor.fromInt(0xFF0F1A2C))),
      pw.Container(height: 0.7, width: 130, color: PdfColors.grey500, margin: const pw.EdgeInsets.symmetric(vertical: 4)),
      pw.Text(title, textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font, fontSize: 9, color: PdfColors.grey700)),
    ],
  );

  static pw.Widget _qr() => pw.Container(
    width: 28, height: 28, decoration: pw.BoxDecoration(border: pw.Border.all(width: 1.5)), padding: const pw.EdgeInsets.all(2),
    child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: List.generate(3, (_) => pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: List.generate(3, (i) => pw.Container(width: 4, height: 4, color: i % 2 == 0 ? PdfColors.black : PdfColors.transparent))))),
  );
}
