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
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  bool _isListening = false;

  // دالة الاستماع والتعرف على الصوت
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _inputController.text = val.recognizedWords;
          });
          if (val.finalResult) {
            _isListening = false;
            _mockTranslate(val.recognizedWords); // استدعاء الترجمة
          }
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // دالة الترجمة (سيتم ربطها بـ ML Kit Translation لاحقاً)
  void _mockTranslate(String text) {
    setState(() {
      _outputController.text = "جاري ترجمة: $text ...";
      // هنا هنحط محرك الترجمة الفعلي في الخطوة الجاية
    });
  }

  // أدوات التحكم (نسخ، لصق، مشاركة)
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
        if (controller.text.isNotEmpty) _tts.speak(controller.text);
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
            // خانة الإدخال (الأصل)
            _buildBox("خانة الكتابة / الصوت", _inputController, true),
            const SizedBox(height: 20),
            const Icon(Icons.arrow_downward, color: Colors.blueAccent, size: 30),
            const SizedBox(height: 20),
            // خانة الترجمة (الناتج)
            _buildBox("خانة الترجمة", _outputController, false),
            const SizedBox(height: 30),
            // أزرار التحكم الرئيسية
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _roundBtn(_isListening ? Icons.stop : Icons.mic, _isListening ? Colors.red : Colors.blueAccent, _listen),
                _roundBtn(Icons.translate, Colors.greenAccent, () => _mockTranslate(_inputController.text)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String label, TextEditingController controller, bool hasMic) {
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
            maxLines: 5,
            style: const TextStyle(color: Colors.white),
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
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
