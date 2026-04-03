import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool _isDarkMode = true;
  String _translatedText = "أدهم وتامر.. ميثاق لا ينكسر";

  bool get isDarkMode => _isDarkMode;
  String get translatedText => _translatedText;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> translate(String text) async {
    _translatedText = "تمت الترجمة: $text";
    notifyListeners();
  }
}
