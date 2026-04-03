import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class AppProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  String _translatedText = "الترجمة ستظهر هنا...";
  String get translatedText => _translatedText;

  bool _isTranslating = false;
  bool get isTranslating => _isTranslating;

  final onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: TranslateLanguage.turkish,
    targetLanguage: TranslateLanguage.arabic,
  );

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Future<void> translate(String text) async {
    if (text.isEmpty) return;
    _isTranslating = true;
    notifyListeners();
    try {
      _translatedText = await onDeviceTranslator.translateText(text);
    } catch (e) {
      _translatedText = "خطأ: تأكد من تحميل حزمة اللغة";
    } finally {
      _isTranslating = false;
      notifyListeners();
    }
  }
}
