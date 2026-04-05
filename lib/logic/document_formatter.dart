import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DocumentFormatter {
  static Future<void> generateA4TranslatedDoc(String translatedText) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4, // التنسيق العالمي للطباعة
        margin: pw.EdgeInsets.all(20), // هوامش حماية للنص
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text("Mirror Ultimate - Translated Document", 
                style: pw.TextStyle(fontSize: 18, color: PdfColors.blueGrey900))),
              pw.Divider(thickness: 1),
              pw.Paragraph(
                text: translatedText,
                style: pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
              ),
            ],
          );
        },
      ),
    );

    // أمر الطباعة المباشرة أو المعاينة
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
