import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';

class TranslatorWorld extends StatefulWidget {
  const TranslatorWorld({super.key});

  @override
  State<TranslatorWorld> createState() => _TranslatorWorldState();
}

class _TranslatorWorldState extends State<TranslatorWorld> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _controller = TextEditingController();
  bool _isListening = false;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _controller.text = val.recognizedWords;
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // دالة النسخ
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _controller.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم نسخ النص!")));
  }

  // دالة اللصق
  void _pasteFromClipboard() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null) {
      setState(() {
        _controller.text = data.text ?? "";
      });
    }
  }

  // دالة المشاركة (نص وصوت)
  void _shareContent() {
    if (_controller.text.isNotEmpty) {
      Share.share(_controller.text, subject: 'ترجمة ميرور ألتيميت');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1014),
      appBar: AppBar(
        title: const Text("عالم المترجم الذكي"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(icon: const Icon(Icons.content_paste), onPressed: _pasteFromClipboard),
          IconButton(icon: const Icon(Icons.copy), onPressed: _copyToClipboard),
          IconButton(icon: const Icon(Icons.share), onPressed: _shareContent),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(
                    hintText: "اكتب هنا أو استخدم المايك...",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "mic",
                  onPressed: _listen,
                  backgroundColor: _isListening ? Colors.red : Colors.blueAccent,
                  child: Icon(_isListening ? Icons.stop : Icons.mic),
                ),
                FloatingActionButton(
                  heroTag: "speak",
                  onPressed: () => _tts.speak(_controller.text),
                  backgroundColor: Colors.greenAccent,
                  child: const Icon(Icons.volume_up, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
