import 'package:flutter/material.dart';

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  String originalText = "النص الأصلي سيظهر هنا...";
  String translatedText = "الترجمة ستظهر هنا...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      appBar: AppBar(title: Text('الترجمة الثنائية')),
      body: Column(
        children: [
          // النص الأصلي
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.white10,
              width: double.infinity,
              child: Text(originalText, style: TextStyle(color: Colors.amber, fontSize: 20)),
            ),
          ),
          Divider(color: Colors.amber, thickness: 2),
          // النص المترجم
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(translatedText, style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
