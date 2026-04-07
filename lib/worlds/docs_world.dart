import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class DocsWorld extends StatefulWidget {
  const DocsWorld({super.key});
  @override
  State<DocsWorld> createState() => _DocsWorldState();
}

class _DocsWorldState extends State<DocsWorld> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  final _translator = OnDeviceTranslator(sourceLanguage: TranslateLanguage.english, targetLanguage: TranslateLanguage.arabic);
  String _status = "اختر مستنداً للبدء (صورة أو PDF)";
  List<String> _translatedLines = [];

  Future<void> _pickAndProcess() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    
    if (result != null) {
      setState(() => _status = "جاري معالجة المستند والترجمة...");
      final inputImage = InputImage.fromFilePath(result.files.single.path!);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      List<String> translated = [];
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          final trans = await _translator.translateText(line.text);
          translated.add(trans);
        }
      }
      
      setState(() {
        _translatedLines = translated;
        _status = "تمت الترجمة بنجاح! جاهز للطباعة.";
      });
    }
  }

  Future<void> _printDocument() async {
    final pdf = pw.Document();
    // استخدام خط يدعم العربية (دستور 2026 يفرض دعم اليونيكود)
    final font = await PdfGoogleFonts.arimoRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: _translatedLines.map((line) => pw.Text(line, 
              style: pw.TextStyle(font: font, fontSize: 14),
              textDirection: pw.TextDirection.rtl)).toList(),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("مترجم المستندات (A4)"), backgroundColor: Colors.green[900]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.description, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            Text(_status, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _pickAndProcess,
              icon: const Icon(Icons.file_open),
              label: const Text("اختيار مستند"),
            ),
            if (_translatedLines.isNotEmpty) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _printDocument,
                icon: const Icon(Icons.print),
                label: const Text("طباعة / حفظ PDF"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
