import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  String _translatedText = "أدهم جاهز يا تامر";

  bool get isDarkMode => _isDarkMode;
  String get translatedText => _translatedText;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateText(String text) {
    _translatedText = text;
    notifyListeners();
  }
}
