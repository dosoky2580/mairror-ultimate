import 'package:flutter_tts/flutter_tts.dart';

class MirrorVoices {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text, String voiceName) async {
    // إعدادات الأصوات (سيف، سلمى، سما، سارة)
    if (voiceName == 'Seif') {
      await _tts.setPitch(0.8);
    } else if (voiceName == 'Salma') {
      await _tts.setPitch(1.2);
    } else if (voiceName == 'Sama') {
      await _tts.setPitch(1.4);
    } else {
      await _tts.setPitch(1.0);
    }
    await _tts.speak(text);
  }
}
