import 'package:flutter_tts/flutter_tts.dart';

class MirrorVoices {
  final FlutterTts _tts = FlutterTts();

  // تفعيل الأصوات الأربعة
  Future<void> speak(String text, String voiceName) async {
    switch (voiceName) {
      case 'Seif': await _tts.setPitch(0.8); await _tts.setSpeechRate(0.5); break;
      case 'Salma': await _tts.setPitch(1.2); await _tts.setSpeechRate(0.45); break;
      case 'Sama': await _tts.setPitch(1.4); await _tts.setSpeechRate(0.5); break;
      case 'Sara': await _tts.setPitch(1.6); await _tts.setSpeechRate(0.55); break;
    }
    await _tts.speak(text);
  }
}
