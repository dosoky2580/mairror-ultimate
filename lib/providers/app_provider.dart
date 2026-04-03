import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool _isDarkMode = true;
  bool _isTranslating = false;
  String _translatedText = "أدهم وتامر.. للنهاية";

  bool get isDarkMode => _isDarkMode;
  bool get isTranslating => _isTranslating;
  String get translatedText => _translatedText;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> translate(String text) async {
    if (text.isEmpty) return;
    _isTranslating = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 1));
    _translatedText = "أدهم يترجم لك: $text";
    
    _isTranslating = false;
    notifyListeners();
  }
}
