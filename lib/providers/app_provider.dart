import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AppProvider with ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  final FlutterTts _flutterTts = FlutterTts();
  
  bool _isDarkMode = true;
  bool _isWorking = false;
  String _resultText = "أهلاً بك في ميرور يا تامر";
  String _selectedVoice = "سيف"; // الصوت الافتراضي

  // إعدادات الأصوات الأربعة
  final Map<String, Map<String, double>> _voices = {
    "سيف": {"pitch": 0.9, "rate": 0.5},   // رجالي هادئ
    "سلمى": {"pitch": 1.2, "rate": 0.5},  // نسائي رقيق
    "سما": {"pitch": 1.5, "rate": 0.6},   // نسائي سريع
    "سارة": {"pitch": 1.0, "rate": 0.45}, // نسائي متزن
  };

  bool get isDarkMode => _isDarkMode;
  bool get isWorking => _isWorking;
  String get resultText => _resultText;
  String get selectedVoice => _selectedVoice;
  List<String> get voiceNames => _voices.keys.toList();
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void setVoice(String name) {
    _selectedVoice = name;
    notifyListeners();
  }

  void toggleTheme() => { _isDarkMode = !_isDarkMode, notifyListeners() };

  Future<void> processText(String text) async {
    if (text.isEmpty) return;
    _isWorking = true;
    notifyListeners();

    try {
      var translation = await _translator.translate(text, to: 'en');
      _resultText = translation.text;
      
      // تطبيق إعدادات الصوت المختار
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(_voices[_selectedVoice]!["pitch"]!);
      await _flutterTts.setSpeechRate(_voices[_selectedVoice]!["rate"]!);
      await _flutterTts.speak(_resultText);
    } catch (e) {
      _resultText = "عذراً يا شريكي، المسار فيه مشكلة";
    }

    _isWorking = false;
    notifyListeners();
  }
}
