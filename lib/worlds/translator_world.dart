import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class TranslatorWorld extends StatefulWidget {
  const TranslatorWorld({super.key});

  @override
  State<TranslatorWorld> createState() => _TranslatorWorldState();
}

class _TranslatorWorldState extends State<TranslatorWorld> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  String _text = "اضغط على المايك وابدأ الكلام...";
  bool _isListening = false;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) => setState(() {
          _text = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            // هنا ممكن نرسل النص لمرحلة الترجمة
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
      appBar: AppBar(title: const Text("عالم المترجم"), backgroundColor: Colors.blueAccent),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(_text, style: const TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
          FloatingActionButton(
            onPressed: _listen,
            backgroundColor: _isListening ? Colors.red : Colors.blue,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
