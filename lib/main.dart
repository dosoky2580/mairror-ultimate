import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MairrorUltimateApp());
}

class MairrorUltimateApp extends StatelessWidget {
  const MairrorUltimateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mairror Ultimate',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Cairo'),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.language, size: 100, color: Colors.white),
                const SizedBox(height: 20),
                const Text('ميرور النهائي', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 40),
                _buildBtn(context, 'ترجمة الصوت 🌐', Icons.mic, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TranslationScreen()))),
                const SizedBox(height: 20),
                _buildBtn(context, 'ترجمة الكاميرا 📸', Icons.camera_alt, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CameraScreen()))),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildBtn(context, title, icon, tap) => GestureDetector(
    onTap: tap,
    child: Container(
      height: 70, width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: Color(0xFF1E3C72)),
        SizedBox(width: 15),
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E3C72))),
      ]),
    ),
  );
}

// شاشة الترجمة (النسخة الكاملة)
class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});
  @override State<TranslationScreen> createState() => _TranslationState();
}
class _TranslationState extends State<TranslationScreen> {
  final TextEditingController _src = TextEditingController();
  final TextEditingController _dst = TextEditingController();
  final FlutterTts _tts = FlutterTts();
  bool _load = false;
  Future<void> _trans() async {
    setState(() => _load = true);
    final res = await http.get(Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=ar&tl=en&dt=t&q=\${Uri.encodeComponent(_src.text)}'));
    if (res.statusCode == 200) {
      _dst.text = json.decode(res.body)[0][0][0];
      await _tts.speak(_dst.text);
    }
    setState(() => _load = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ترجمة الصوت'), backgroundColor: Color(0xFF1E3C72)),
      body: Padding(padding: EdgeInsets.all(20), child: Column(children: [
        TextField(controller: _src, maxLines: 3, decoration: InputDecoration(border: OutlineInputBorder())),
        SizedBox(height: 20),
        ElevatedButton(onPressed: _trans, child: _load ? CircularProgressIndicator() : Text('ترجمة ونطق')),
        SizedBox(height: 20),
        TextField(controller: _dst, maxLines: 3, enabled: false, decoration: InputDecoration(border: OutlineInputBorder())),
      ])),
    );
  }
}

// شاشة الكاميرا
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override State<CameraScreen> createState() => _CameraState();
}
class _CameraState extends State<CameraScreen> {
  CameraController? _c;
  @override void initState() { super.initState(); availableCameras().then((cam) { _c = CameraController(cam[0], ResolutionPreset.high); _c!.initialize().then((_) => setState(() {})); }); }
  @override Widget build(BuildContext context) {
    if (_c == null || !_c!.value.isInitialized) return Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(body: CameraPreview(_c!));
  }
}
