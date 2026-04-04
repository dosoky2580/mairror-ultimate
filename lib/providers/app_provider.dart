import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

class AppProvider with ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  final FlutterTts _flutterTts = FlutterTts();
  
  bool _isDarkMode = true;
  bool _isWorking = false;
  String _resultText = "";
  String _selectedVoice = "سيف";
  String _targetLang = "en";
  List<String> _history = []; // سجل الذاكرة

  final Map<String, String> languages = {"إنجليزي": "en", "تركي": "tr", "فرنسي": "fr", "ألماني": "de", "عربي": "ar"};
  final Map<String, Map<String, double>> _voices = {
    "سيف": {"pitch": 0.8, "rate": 0.45},
    "سلمى": {"pitch": 1.2, "rate": 0.5},
    "سما": {"pitch": 1.6, "rate": 0.6},
    "سارة": {"pitch": 1.0, "rate": 0.4},
  };

  bool get isDarkMode => _isDarkMode;
  bool get isWorking => _isWorking;
  String get resultText => _resultText;
  String get selectedVoice => _selectedVoice;
  List<String> get voiceNames => _voices.keys.toList();
  List<String> get history => _history;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() { _isDarkMode = !_isDarkMode; notifyListeners(); }
  void setVoice(String name) { _selectedVoice = name; notifyListeners(); }
  void setTargetLang(String code) { _targetLang = code; notifyListeners(); }

  Future<void> translateFree(String text, {String from = 'ar', String to = 'en'}) async {
    if (text.trim().isEmpty) {
      HapticFeedback.vibrate();
      return;
    }
    _isWorking = true;
    notifyListeners();
    try {
      var translation = await _translator.translate(text, from: from, to: to);
      _resultText = translation.text;
      
      // إضافة للسجل لو مش موجودة
      if (!_history.contains(text)) {
        _history.insert(0, text);
        if (_history.length > 5) _history.removeLast();
      }
      
      await speak();
    } catch (e) { _resultText = "تأكد من الإنترنت"; }
    _isWorking = false;
    notifyListeners();
  }

  Future<void> speak() async {
    await _flutterTts.setPitch(_voices[_selectedVoice]!["pitch"]!);
    await _flutterTts.setSpeechRate(_voices[_selectedVoice]!["rate"]!);
    await _flutterTts.speak(_resultText);
  }

  void clearHistory() { _history.clear(); notifyListeners(); }
}
