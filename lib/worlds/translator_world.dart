import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

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
  
  // إعداد محرك الترجمة (من عربي لإنجليزي)
  late OnDeviceTranslator _onDeviceTranslator;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.arabic,
      targetLanguage: TranslateLanguage.english,
    );
  }

  @override
  void dispose() {
    _onDeviceTranslator.close();
    super.dispose();
  }

  // دالة الترجمة الفعلية
  Future<void> _translateText() async {
    if (_inputController.text.isEmpty) return;
    
    setState(() => _outputController.text = "جاري الترجمة... ⏳");
    
    try {
      final String translation = await _onDeviceTranslator.translateText(_inputController.text);
      setState(() {
        _outputController.text = translation;
      });
    } catch (e) {
      setState(() => _outputController.text = "خطأ: تأكد من تحميل حزمة اللغة");
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() => _inputController.text = val.recognizedWords);
          if (val.finalResult) {
            setState(() => _isListening = false);
            _translateText(); // ترجمة تلقائية بعد انتهاء الكلام
          }
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _handleTool(String action, TextEditingController controller) async {
    switch (action) {
      case 'copy':
        Clipboard.setData(ClipboardData(text: controller.text));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم النسخ!")));
        break;
      case 'paste':
        ClipboardData? data = await Clipboard.getData('text/plain');
        if (data != null) setState(() => controller.text = data.text ?? "");
        break;
      case 'share':
        if (controller.text.isNotEmpty) Share.share(controller.text);
        break;
      case 'speak':
        if (controller.text.isNotEmpty) {
           // إذا كانت الخانة هي الترجمة، ننطق بالإنجليزي
           if (controller == _outputController) await _tts.setLanguage("en-US");
           else await _tts.setLanguage("ar-SA");
           await _tts.speak(controller.text);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1014),
      appBar: AppBar(title: const Text("ميرور - الترجمة الفورية"), backgroundColor: Colors.blueGrey[900]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildBox("خانة الكتابة / الصوت", _inputController),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Icon(Icons.arrow_downward, color: Colors.blueAccent, size: 30),
            ),
            _buildBox("خانة الترجمة", _outputController),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _roundBtn(_isListening ? Icons.stop : Icons.mic, _isListening ? Colors.red : Colors.blueAccent, _listen),
                _roundBtn(Icons.translate, Colors.greenAccent, _translateText),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(icon: const Icon(Icons.content_paste, size: 20, color: Colors.blue), onPressed: () => _handleTool('paste', controller)),
                IconButton(icon: const Icon(Icons.copy, size: 20, color: Colors.blue), onPressed: () => _handleTool('copy', controller)),
                IconButton(icon: const Icon(Icons.share, size: 20, color: Colors.blue), onPressed: () => _handleTool('share', controller)),
                IconButton(icon: const Icon(Icons.volume_up, size: 20, color: Colors.greenAccent), onPressed: () => _handleTool('speak', controller)),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white10)),
          child: TextField(
            controller: controller,
            maxLines: 4,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: const InputDecoration(border: InputBorder.none, hintText: "..."),
          ),
        ),
      ],
    );
  }

  Widget _roundBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10)]),
        child: Icon(icon, color: Colors.white, size: 35),
      ),
    );
  }
}
