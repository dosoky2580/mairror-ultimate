import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class TranslatorWorld extends StatefulWidget {
  const TranslatorWorld({super.key});
  @override
  State<TranslatorWorld> createState() => _TranslatorWorldState();
}

class _TranslatorWorldState extends State<TranslatorWorld> {
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = "";
  final FlutterTts _tts = FlutterTts();
  final SpeechToText _stt = SpeechToText();
  bool _isListening = false;

  Future<void> _runTranslation() async {
    if (_inputController.text.isEmpty) return;
    setState(() => _translatedText = "جاري الترجمة...");
    final translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.arabic,
      targetLanguage: TranslateLanguage.turkish,
    );
    try {
      final result = await translator.translateText(_inputController.text);
      setState(() => _translatedText = result);
    } catch (e) {
      setState(() => _translatedText = "خطأ في المحرك");
    }
    translator.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("أدهم AI - المترجم الشامل"), backgroundColor: Colors.blueGrey[900]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildBox("خانة الإدخال", _inputController, true),
            const Icon(Icons.swap_vert, color: Colors.blue, size: 30),
            _buildBox("الترجمة النهائية", TextEditingController(text: _translatedText), false),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "mic",
                  backgroundColor: _isListening ? Colors.red : Colors.blue,
                  onPressed: () async {
                    if (!_isListening) {
                      bool available = await _stt.initialize();
                      if (available) {
                        setState(() => _isListening = true);
                        _stt.listen(onResult: (val) => setState(() => _inputController.text = val.recognizedWords));
                      }
                    } else {
                      setState(() => _isListening = false);
                      _stt.stop();
                    }
                  },
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                ),
                FloatingActionButton(
                  heroTag: "trans",
                  backgroundColor: Colors.green,
                  onPressed: _runTranslation,
                  child: const Icon(Icons.translate),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String label, TextEditingController ctrl, bool isInput) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white24)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.blueAccent)),
              Row(children: [
                IconButton(icon: const Icon(Icons.copy, color: Colors.grey, size: 20), onPressed: () => Clipboard.setData(ClipboardData(text: ctrl.text))),
                IconButton(icon: const Icon(Icons.share, color: Colors.green, size: 20), onPressed: () => Share.share(ctrl.text)),
                if (!isInput) IconButton(icon: const Icon(Icons.volume_up, color: Colors.orange, size: 20), onPressed: () => _tts.speak(ctrl.text)),
              ]),
            ],
          ),
          TextField(controller: ctrl, maxLines: 4, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(border: InputBorder.none)),
        ],
      ),
    );
  }
}
