import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
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
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  
  TranslateLanguage _sourceLang = TranslateLanguage.arabic;
  TranslateLanguage _targetLang = TranslateLanguage.english;
  late OnDeviceTranslator _translator;

  @override
  void initState() {
    super.initState();
    _initTranslator();
  }

  void _initTranslator() {
    _translator = OnDeviceTranslator(sourceLanguage: _sourceLang, targetLanguage: _targetLang);
  }

  Future<void> _translate() async {
    if (_inputController.text.isEmpty) return;
    setState(() => _outputController.text = "جاري الترجمة...");
    try {
      final result = await _translator.translateText(_inputController.text);
      setState(() => _outputController.text = result);
    } catch (e) {
      setState(() => _outputController.text = "تأكد من تحميل حزمة اللغة من الإعدادات");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("مترجم الـ 100 لغة"), backgroundColor: Colors.blueGrey[900]),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _langPicker(_sourceLang, (val) => setState(() { _sourceLang = val!; _initTranslator(); })),
                const Icon(Icons.swap_horiz, color: Colors.blue),
                _langPicker(_targetLang, (val) => setState(() { _targetLang = val!; _initTranslator(); })),
              ],
            ),
            const SizedBox(height: 20),
            _inputBox(),
            const SizedBox(height: 20),
            _outputBox(),
            const Spacer(),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _langPicker(TranslateLanguage current, ValueChanged<TranslateLanguage?> onChange) {
    return DropdownButton<TranslateLanguage>(
      value: current,
      dropdownColor: Colors.grey[900],
      style: const TextStyle(color: Colors.white),
      items: TranslateLanguage.values.map((lang) => DropdownMenuItem(value: lang, child: Text(lang.name.toUpperCase()))).toList(),
      onChanged: onChange,
    );
  }

  Widget _inputBox() => TextField(controller: _inputController, maxLines: 3, style: const TextStyle(color: Colors.white), decoration: InputDecoration(filled: true, fillColor: Colors.grey[900], hintText: "اكتب هنا...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))));
  Widget _outputBox() => TextField(controller: _outputController, readOnly: true, maxLines: 3, style: const TextStyle(color: Colors.greenAccent), decoration: InputDecoration(filled: true, fillColor: Colors.grey[900], hintText: "الترجمة ستظهر هنا", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))));
  
  Widget _buildControls() => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    CircleAvatar(radius: 30, backgroundColor: Colors.blue, child: IconButton(icon: const Icon(Icons.mic, color: Colors.white), onPressed: () {})),
    CircleAvatar(radius: 30, backgroundColor: Colors.green, child: IconButton(icon: const Icon(Icons.translate, color: Colors.white), onPressed: _translate)),
  ]);
}
