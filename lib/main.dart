import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MairrorUltimateApp(cameras: cameras));
}

class MairrorUltimateApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MairrorUltimateApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1E3C72),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: Dashboard(cameras: cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Dashboard extends StatelessWidget {
  final List<CameraDescription> cameras;
  const Dashboard({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mairror Ultimate"), centerTitle: true, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.count(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15,
          children: [
            _card(context, "المترجم الذكي", Icons.g_translate, Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VoiceTransScreen()))),
            _card(context, "عدسة ميرور", Icons.camera_alt, Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (_) => CameraLensScreen(cameras: cameras)))),
            _card(context, "الكتب والمستندات", Icons.menu_book, Colors.green, () {}),
            _card(context, "ركن الإلهام", Icons.auto_awesome, Colors.purple, () {}),
          ],
        ),
      ),
    );
  }

  Widget _card(context, title, icon, color, tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 50, color: color),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

// --- إصلاح المترجم (عشان ميعرضش كود) ---
class VoiceTransScreen extends StatefulWidget {
  const VoiceTransScreen({super.key});
  @override State<VoiceTransScreen> createState() => _VoiceTransState();
}
class _VoiceTransState extends State<VoiceTransScreen> {
  final TextEditingController _in = TextEditingController();
  String _out = "";
  Future<void> _translate() async {
    final res = await http.get(Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=ar&tl=en&dt=t&q=${Uri.encodeComponent(_in.text)}'));
    setState(() => _out = json.decode(res.body)[0][0][0]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المترجم الفوري")),
      body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
        TextField(controller: _in, decoration: const InputDecoration(hintText: "اكتب هنا...")),
        ElevatedButton(onPressed: _translate, child: const Text("ترجمة")),
        const SizedBox(height: 30),
        Text(_out, style: const TextStyle(fontSize: 22, color: Colors.greenAccent)),
      ])),
    );
  }
}

// --- إصلاح العدسة (تفعيل الكاميرا الحقيقية) ---
class CameraLensScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraLensScreen({super.key, required this.cameras});
  @override State<CameraLensScreen> createState() => _CameraLensState();
}
class _CameraLensState extends State<CameraLensScreen> {
  late CameraController _ctrl;
  @override void initState() { super.initState(); _ctrl = CameraController(widget.cameras[0], ResolutionPreset.max); _ctrl.initialize().then((_) => setState(() {})); }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    if (!_ctrl.value.isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      body: Stack(children: [
        CameraPreview(_ctrl),
        Positioned(bottom: 30, left: 0, right: 0, child: Center(child: IconButton(icon: const Icon(Icons.circle, size: 70, color: Colors.white), onPressed: () {}))),
        Positioned(top: 40, left: 20, child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context))),
      ]),
    );
  }
}
