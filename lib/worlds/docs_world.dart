import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class DocsWorld extends StatefulWidget {
  const DocsWorld({super.key});
  @override
  State<DocsWorld> createState() => _DocsWorldState();
}

class _DocsWorldState extends State<DocsWorld> {
  String _status = "اختر ملف PDF أو صورة";
  List<String> _lines = [];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() => _status = "جاري قراءة الملف...");
      // هنا بنضيف منطق قراءة الـ PDF وتحويله لنص مترجم
      // للتبسيط في العرض:
      setState(() {
        _lines = ["تم استخراج النص من المستند المختار بنجاح"];
        _status = "جاهز للطباعة بـ A4";
      });
    }
  }

  Future<void> _printA4() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.arimoRegular();
    pdf.addPage(pw.Page(build: (pw.Context context) => pw.Center(
      child: pw.Text(_lines.join("\n"), style: pw.TextStyle(font: font, fontSize: 18))
    )));
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("مترجم المستندات A4"), backgroundColor: Colors.green[900]),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.picture_as_pdf, size: 100, color: Colors.red),
        const SizedBox(height: 20),
        Text(_status, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: _pickFile, child: const Text("اختيار مستند (PDF/Image)")),
        if(_lines.isNotEmpty) IconButton(icon: const Icon(Icons.print, size: 50, color: Colors.blue), onPressed: _printA4)
      ])),
    );
  }
}
