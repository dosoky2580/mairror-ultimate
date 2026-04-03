import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AppProvider with ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speech = SpeechToText();
  
  bool _isDarkMode = true;
  bool _isWorking = false;
  String _originalText = "اضغط للتحدث..."; 
  String _resultText = "الترجمة ستظهر هنا";
  String _selectedVoice = "سيف";
  String _targetLangCode = "en";

  final Map<String, String> languages = {"إنجليزي": "en", "تركي": "tr", "فرنسي": "fr", "ألماني": "de"};
  final Map<String, Map<String, double>> _voices = {
    "سيف": {"pitch": 0.8, "rate": 0.45},
    "سلمى": {"pitch": 1.2, "rate": 0.5},
    "سما": {"pitch": 1.6, "rate": 0.6},
    "سارة": {"pitch": 1.0, "rate": 0.4},
  };

  bool get isDarkMode => _isDarkMode;
  bool get isWorking => _isWorking;
  String get originalText => _originalText;
  String get resultText => _resultText;
  String get selectedVoice => _selectedVoice;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() { _isDarkMode = !_isDarkMode; notifyListeners(); }
  void setVoice(String name) { _selectedVoice = name; notifyListeners(); }
  void setTargetLang(String code) { _targetLangCode = code; notifyListeners(); }

  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _isWorking = true;
      _originalText = "أنا أسمعك الآن...";
      notifyListeners();
      _speech.listen(onResult: (val) {
        _originalText = val.recognizedWords;
        if (val.finalResult) {
          translate(_originalText);
        }
        notifyListeners();
      }, localeId: "ar-EG");
    }
  }

  Future<void> translate(String text) async {
    try {
      var translation = await _translator.translate(text, to: _targetLangCode);
      _resultText = translation.text;
      await speak();
    } catch (e) { _resultText = "خطأ في الاتصال"; }
    _isWorking = false;
    notifyListeners();
  }

  Future<void> speak() async {
    await _flutterTts.setPitch(_voices[_selectedVoice]!["pitch"]!);
    await _flutterTts.speak(_resultText);
  }
}
