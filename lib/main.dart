import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
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
      appBar: AppBar(title: const Text("Mirror Ultimate v2.0"), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.auto_awesome, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15,
                children: [
                  _btn(context, "العدسة الذكية", Icons.camera_enhance, Colors.cyan, () => Navigator.push(context, MaterialPageRoute(builder: (_) => CameraLensScreen(cameras: cameras)))),
                  _btn(context, "مترجم الصوت", Icons.mic, Colors.greenAccent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TranslatorScreen()))),
                  _btn(context, "المستندات", Icons.description, Colors.orange, () {}),
                  _btn(context, "الإعدادات", Icons.settings, Colors.grey, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(context, title, icon, color, tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(25), border: Border.all(color: color.withOpacity(0.3))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 45, color: color),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});
  @override State<TranslatorScreen> createState() => _TranslatorState();
}

class _TranslatorState extends State<TranslatorScreen> {
  final TextEditingController _in = TextEditingController();
  String _out = "الترجمة ستظهر هنا...";
  bool _loading = false;

  Future<void> _translate() async {
    if (_in.text.isEmpty) return;
    setState(() => _loading = true);
    try {
      final res = await http.get(Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en&dt=t&q=${Uri.encodeComponent(_in.text)}'));
      setState(() => _out = json.decode(res.body)[0][0][0]);
    } catch (e) {
      setState(() => _out = "خطأ في الاتصال");
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المترجم الفوري")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: _in, maxLines: 4, decoration: const InputDecoration(hintText: "أدخل النص للترجمة...", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _translate, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)), child: _loading ? const CircularProgressIndicator() : const Text("ترجمة الآن")),
          const SizedBox(height: 40),
          Container(width: double.infinity, padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)), child: Text(_out, style: const TextStyle(fontSize: 20, color: Colors.cyanAccent))),
        ]),
      ),
    );
  }
}

class CameraLensScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraLensScreen({super.key, required this.cameras});
  @override State<CameraLensScreen> createState() => _CameraLensState();
}

class _CameraLensState extends State<CameraLensScreen> {
  late CameraController _ctrl;
  @override void initState() { super.initState(); _ctrl = CameraController(widget.cameras[0], ResolutionPreset.high); _ctrl.initialize().then((_) => setState(() {})); }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    if (!_ctrl.value.isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      body: Stack(children: [
        CameraPreview(_ctrl),
        Positioned(top: 40, left: 20, child: IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 30), onPressed: () => Navigator.pop(context))),
        Positioned(bottom: 50, left: 0, right: 0, child: const Center(child: Text("وجه الكاميرا نحو النص", style: TextStyle(color: Colors.white, backgroundColor: Colors.black54, fontSize: 18)))),
      ]),
    );
  }
}
