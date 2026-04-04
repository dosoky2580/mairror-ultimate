import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts _tts = FlutterTts();
  bool _isListening = false;
  String _text = "اضغط على المايك وابدأ الكلام...";

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) => setState(() {
          _text = val.recognizedWords;
          if (val.finalResult) {
            _isListening = false;
            // هنا هيتم استدعاء الترجمة الآلية في الخطوة الجاية
          }
        }));
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('المترجم الفوري (صوت سيف)')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(_text, textAlign: TextAlign.center, 
                style: const TextStyle(fontSize: 22, color: Colors.white)),
          ),
          const SizedBox(height: 50),
          Center(
            child: GestureDetector(
              onTap: _listen,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: _isListening ? Colors.red : Colors.blue,
                child: Icon(_isListening ? Icons.mic : Icons.mic_none, 
                           size: 40, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(_isListening ? "جاري الاستماع..." : "اضغط للتحدث", 
               style: TextStyle(color: _isListening ? Colors.red : Colors.grey)),
        ],
      ),
    );
  }
}
