import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AppProvider with ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  final FlutterTts _flutterTts = FlutterTts();
  
  bool _isDarkMode = true;
  bool _isWorking = false;
  String _resultText = "أهلاً بك يا تamer في عالمك المنظم";

  bool get isDarkMode => _isDarkMode;
  bool get isWorking => _isWorking;
  String get resultText => _resultText;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> processText(String text) async {
    if (text.isEmpty) return;
    _isWorking = true;
    notifyListeners();

    try {
      // 1. الترجمة للإنجليزية (كمثال)
      var translation = await _translator.translate(text, to: 'en');
      _resultText = translation.text;
      
      // 2. النطق الصوتي
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.speak(_resultText);
    } catch (e) {
      _resultText = "عذراً يا شريكي، حدث خطأ بسيط";
    }

    _isWorking = false;
    notifyListeners();
  }
}
