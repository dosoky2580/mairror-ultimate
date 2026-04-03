import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AppProvider with ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  final FlutterTts _flutterTts = FlutterTts();
  
  bool _isDarkMode = true;
  bool _isWorking = false;
  String _resultText = "عالم ميرور يرحب بك";
  String _selectedVoice = "سيف";
  String _targetLanguage = "en";

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
  
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setVoice(String name) {
    _selectedVoice = name;
    notifyListeners();
  }

  Future<void> translate(String text) async {
    if (text.isEmpty) return;
    _isWorking = true;
    notifyListeners();
    try {
      var translation = await _translator.translate(text, to: _targetLanguage);
      _resultText = translation.text;
      await speak();
    } catch (e) {
      _resultText = "تأكد من الاتصال بالإنترنت يا شريكي";
    }
    _isWorking = false;
    notifyListeners();
  }

  Future<void> speak() async {
    await _flutterTts.setPitch(_voices[_selectedVoice]!["pitch"]!);
    await _flutterTts.setSpeechRate(_voices[_selectedVoice]!["rate"]!);
    await _flutterTts.speak(_resultText);
  }
}
