import 'package:flutter/material.dart';

class DocumentTranslationScreen extends StatefulWidget {
  @override
  _DocumentTranslationScreenState createState() => _DocumentTranslationScreenState();
}

class _DocumentTranslationScreenState extends State<DocumentTranslationScreen> {
  bool _isProcessing = false;
  String _statusMessage = "ارفع مستند أو كتاب للترجمة (PDF/DOCX)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      appBar: AppBar(
        title: Text("مترجم المستندات والكتب"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.library_books, size: 80, color: Colors.tealAccent),
            SizedBox(height: 20),
            Text(_statusMessage, style: TextStyle(color: Colors.white70)),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isProcessing = true;
                  _statusMessage = "جاري قراءة الكتاب وترجمته...";
                });
                // منطق معالجة المستندات اللي في الكتالوج
              },
              icon: Icon(Icons.upload_file),
              label: Text("اختيار ملف من الذاكرة"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            if (_isProcessing) 
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LinearProgressIndicator(color: Colors.tealAccent),
              ),
          ],
        ),
      ),
    );
  }
}
