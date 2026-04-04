import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  String _text = '';
  String _translated = '';
  bool _isListening = false;

  void _listen() async {
    bool avail = await _speech.initialize();
    if (avail) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) => setState(() => _text = val.recognizedWords));
    }
  }

  Future<void> _translate() async {
    // هنا بنستخدم الـ API اللي إنت بعته
    final response = await http.post(
      Uri.parse('https://translation.googleapis.com/language/translate/v2'),
      body: {'q': _text, 'target': 'en', 'key': 'YOUR_KEY'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() => _translated = data['data']['translations'][0]['translatedText']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🌐 مترجم ميرور')),
      body: Column(
        children: [
          Expanded(child: Center(child: Text(_text))),
          if (_translated.isNotEmpty) Text(_translated, style: TextStyle(fontSize: 20, color: Colors.blue)),
          IconButton(icon: Icon(_isListening ? Icons.mic : Icons.mic_none), onPressed: _listen),
          ElevatedButton(onPressed: _translate, child: Text('ترجمة الآن')),
        ],
      ),
    );
  }
}
