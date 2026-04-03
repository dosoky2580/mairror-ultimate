import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  // إعدادات المظهر
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  // إعدادات اللغة (Default: Turkish for your work)
  String _currentLanguage = 'tr';
  String get currentLanguage => _currentLanguage;

  // عداد الإنجازات (Achievements)
  int _translationCount = 0;
  int get translationCount => _translationCount;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void incrementAchievements() {
    _translationCount++;
    notifyListeners();
  }

  void setLanguage(String langCode) {
    _currentLanguage = langCode;
    notifyListeners();
  }
}
