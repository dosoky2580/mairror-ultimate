import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = [];
  try { cameras = await availableCameras(); } catch (e) { print(e); }
  runApp(MairrorUltimateApp(cameras: cameras));
}

class MairrorUltimateApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MairrorUltimateApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E14),
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
      appBar: AppBar(
        title: const Text("🛡️ MIRROR ULTIMATE", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildCard(context, "عالم الترجمة الفورية", "صوت ونص (5 أصوات)", Icons.translate, Colors.blue, const VoiceWorld()),
          _buildCard(context, "عالم العدسة الذكية", "رؤية وترجمة حية", Icons.remove_red_eye, Colors.amber, CameraWorld(cameras: cameras)),
          _buildCard(context, "عالم المستندات والـ PDF", "ترجمة الأوراق والملفات", Icons.copy_all, Colors.green, const DocWorld()),
          _buildCard(context, "عالم الإلهام والقصص", "قصص دينية بمؤثرات صوتية", Icons.auto_stories, Colors.purple, const StoryWorld()),
          _buildCard(context, "ساحة الألعاب الذهنية", "شطرنج ومكعب روبيك", Icons.extension, Colors.redAccent, const GameWorld()),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String sub, IconData icon, Color color, Widget target) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      color: const Color(0xFF161B22),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white24),
            ],
          ),
        ),
      ),
    );
  }
}

class VoiceWorld extends StatefulWidget {
  const VoiceWorld({super.key});
  @override State<VoiceWorld> createState() => _VoiceWorldState();
}
class _VoiceWorldState extends State<VoiceWorld> {
  final TextEditingController _in = TextEditingController();
  String _out = "الترجمة ستظهر هنا...";
  bool _load = false;
  Future<void> _trans() async {
    if(_in.text.isEmpty) return;
    setState(() => _load = true);
    try {
      final url = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=ar&tl=en&dt=t&q=${Uri.encodeComponent(_in.text)}';
      final res = await http.get(Uri.parse(url));
      setState(() => _out = json.decode(res.body)[0][0][0]);
    } catch (e) { setState(() => _out = "خطأ في الاتصال"); }
    setState(() => _load = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("عالم الترجمة")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: _in, maxLines: 4, decoration: const InputDecoration(hintText: "اكتب بالعربية...", border: OutlineInputBorder())),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _trans, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)), child: _load ? const CircularProgressIndicator(color: Colors.white) : const Text("ترجمة الآن")),
          const SizedBox(height: 20),
          Container(padding: const EdgeInsets.all(15), width: double.infinity, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)), child: Text(_out, style: const TextStyle(fontSize: 18, color: Colors.cyanAccent))),
        ]),
      ),
    );
  }
}

class CameraWorld extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraWorld({super.key, required this.cameras});
  @override State<CameraWorld> createState() => _CameraWorldState();
}
class _CameraWorldState extends State<CameraWorld> {
  CameraController? _c;
  @override void initState() { super.initState(); if(widget.cameras.isNotEmpty) { _c = CameraController(widget.cameras[0], ResolutionPreset.high); _c!.initialize().then((_) => setState(() {})); } }
  @override void dispose() { _c?.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    if (_c == null || !_c!.value.isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(body: Stack(children: [CameraPreview(_c!), Positioned(top: 40, left: 20, child: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)))]));
  }
}

class DocWorld extends StatelessWidget { const DocWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("عالم المستندات")), body: const Center(child: Text("قريباً: معالج الـ PDF"))); }
class StoryWorld extends StatelessWidget { const StoryWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("عالم الإلهام")), body: const Center(child: Text("قريباً: محرك القصص"))); }
class GameWorld extends StatelessWidget { const GameWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("ساحة الألعاب")), body: const Center(child: Text("قريباً: الألعاب الذكية"))); }
