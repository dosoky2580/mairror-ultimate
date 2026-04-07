import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslatorWorld extends StatefulWidget {
  const TranslatorWorld({super.key});
  @override
  State<TranslatorWorld> createState() => _TranslatorWorldState();
}

class _TranslatorWorldState extends State<TranslatorWorld> {
  final TextEditingController _controller = TextEditingController();
  String _translatedText = "";
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  final _translator = OnDeviceTranslator(sourceLanguage: TranslateLanguage.english, targetLanguage: TranslateLanguage.arabic);

  Future<void> _translate() async {
    if (_controller.text.isEmpty) return;
    final result = await _translator.translateText(_controller.text);
    setState(() => _translatedText = result);
  }

  Future<void> _listen() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(onResult: (val) => setState(() => _controller.text = val.recognizedWords));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("مترجم الـ 100 لغة"),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () => Share.share(_translatedText)),
          IconButton(icon: const Icon(Icons.copy), onPressed: () => Clipboard.setData(ClipboardData(text: _translatedText))),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "اكتب أو استعمل المايك...",
                suffixIcon: IconButton(icon: const Icon(Icons.paste, color: Colors.blue), onPressed: () async {
                  var data = await Clipboard.getData('text/plain');
                  if (data != null) _controller.text = data.text!;
                }),
              ),
            ),
          ),
          ElevatedButton(onPressed: _translate, child: const Text("ترجم الآن")),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
              child: SelectableText(_translatedText, style: const TextStyle(color: Colors.greenAccent, fontSize: 18)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(onPressed: _listen, backgroundColor: Colors.blue, child: const Icon(Icons.mic)),
              FloatingActionButton(onPressed: () => _tts.speak(_translatedText), backgroundColor: Colors.green, child: const Icon(Icons.volume_up)),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
