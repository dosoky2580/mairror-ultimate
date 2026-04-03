import 'package:flutter/material.dart';
class AppProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  String _text = "أدهم وتامر.. للنهاية";
  bool get isDarkMode => _isDarkMode;
  String get translatedText => _text;
  void toggleTheme() { _isDarkMode = !_isDarkMode; notifyListeners(); }
}
