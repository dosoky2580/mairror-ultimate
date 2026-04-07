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
  String _originalText = "اضغط وابدأ الكلام...";
  String _translatedText = "";
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _setupTts();
  }

  void _setupTts() {
    _tts.setLanguage("ar-SA"); // لغة الرد الأساسية
    _tts.setPitch(1.0);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _originalText = val.recognizedWords;
          });
          if (val.finalResult) {
            _translateAndSpeak(_originalText);
          }
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // محاكاة للترجمة والرد الصوتي (سيتم ربطها بـ API لاحقاً)
  Future<void> _translateAndSpeak(String text) async {
    setState(() => _isListening = false);
    
    // مثال للرد التفاعلي من أدهم
    if (text.contains("ادهم")) {
      String response = "مساء الفل يا تامر، أنا سامعك ومستعد للترجمة.";
      setState(() => _translatedText = response);
      await _tts.speak(response);
    } else {
      // هنا ستوضع معادلة الترجمة الفعلية
      setState(() => _translatedText = "جاري معالجة الترجمة لـ: $text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1014),
      appBar: AppBar(
        title: const Text("عالم المترجم"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          _buildChatBubble(_originalText, true),
          const SizedBox(height: 20),
          if (_translatedText.isNotEmpty) _buildChatBubble(_translatedText, false),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.bottom(50),
            child: GestureDetector(
              onTap: _listen,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _isListening ? Colors.redAccent : Colors.blueAccent,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 20)],
                ),
                child: Icon(_isListening ? Icons.stop : Icons.mic, size: 40, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isOriginal) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isOriginal ? Colors.grey[900] : Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.right,
      ),
    );
  }
}
