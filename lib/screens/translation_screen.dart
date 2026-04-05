import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  FlutterTts flutterTts = FlutterTts();
  bool _isListening = false;
  String _targetLang = "Arabic";

  Future speak(String text) async {
    await flutterTts.setLanguage(_targetLang == "Arabic" ? "ar-SA" : "en-US");
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey[900]!, Colors.black],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("المترجم الفوري الذكي", 
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () => setState(() => _isListening = !_isListening),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: _isListening ? Colors.red : Colors.tealAccent,
                child: Icon(_isListening ? Icons.stop : Icons.mic, size: 40, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
