import 'package:flutter_tts/flutter_tts.dart';

class VoiceEngine {
  static FlutterTts _tts = FlutterTts();

  static Future<void> speakAs(String name, String text) async {
    // إعدادات افتراضية بناءً على خريطة "ميرور 2026"
    switch (name.toLowerCase()) {
      case 'seif': // صوت ذكوري طفولي
        await _tts.setPitch(1.2);
        await _tts.setSpeechRate(0.5);
        break;
      case 'salma': // صوت أنثوي ناعم
      case 'sama':
        await _tts.setPitch(1.0);
        await _tts.setSpeechRate(0.4);
        break;
      case 'sara': // صوت أنثوي هادئ
        await _tts.setPitch(0.8);
        await _tts.setSpeechRate(0.45);
        break;
      default:
        await _tts.setPitch(1.0);
    }
    await _tts.speak(text);
  }
}
