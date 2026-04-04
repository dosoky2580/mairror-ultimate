import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = "النص المترجم سيظهر هنا...";
  bool _isListening = false;
  stt.SpeechToText _speech = stt.SpeechToText();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _clearAll() {
    setState(() {
      _inputController.clear();
      _translatedText = "النص المترجم سيظهر هنا...";
    });
  }

  void _shareContent() {
    Share.share('$_translatedText \n\n تم عبر تطبيق: 🛡️ Mairror Ultimate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('ركن الترجمة الفوري'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'ترجمة نصية'), Tab(text: 'حديث طرفين')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStandardTranslation(),
          _buildConversationMode(),
        ],
      ),
    );
  }

  // 1. واجهة الترجمة القياسية (نص فوق، مترجم تحت)
  Widget _buildStandardTranslation() {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF1D1E33), borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                TextField(
                  controller: _inputController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(hintText: "اكتب النص أو استخدم المايك...", border: InputBorder.none),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.clear, color: Colors.red), onPressed: _clearAll),
                    IconButton(icon: const Icon(Icons.mic, color: Colors.blue), onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
        const Divider(color: Colors.amber, thickness: 2),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF1D1E33), borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Text(_translatedText, style: const TextStyle(color: Colors.greenAccent, fontSize: 18)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(icon: const Icon(Icons.volume_up, color: Colors.green), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.copy, color: Colors.grey), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.share, color: Colors.amber), onPressed: _shareContent),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 2. واجهة حديث الطرفين
  Widget _buildConversationMode() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('وضع المحادثة الفورية', style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _langButton("العربية"),
              const Icon(Icons.swap_horiz, color: Colors.amber, size: 40),
              _langButton("English"),
            ],
          ),
          const SizedBox(height: 100),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: IconButton(icon: const Icon(Icons.mic, size: 40, color: Colors.white), onPressed: () {}),
          ),
          const SizedBox(height: 20),
          const Text('اضغط للتحدث (المسح تلقائي)', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _langButton(String lang) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(10)),
      child: Text(lang, style: const TextStyle(color: Colors.white)),
    );
  }
}
