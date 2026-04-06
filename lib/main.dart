import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
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
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0B0E14)),
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
      appBar: AppBar(title: const Text("🛡️ MIRROR ULTIMATE"), centerTitle: true, backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildCard(context, "عالم الترجمة الفورية", "شغال ✅ (صوت، نسخ، ترجمة ثنائية)", Icons.translate, Colors.blue, const VoiceWorld()),
          _buildCard(context, "عالم العدسة الذكية", "جاري التثبيت ⚙️", Icons.remove_red_eye, Colors.amber, CameraWorld(cameras: cameras)),
          _buildCard(context, "عالم المستندات والـ PDF", "قريباً..", Icons.copy_all, Colors.green, const DocWorld()),
          _buildCard(context, "عالم الإلهام والقصص", "قريباً..", Icons.auto_stories, Colors.purple, const StoryWorld()),
          _buildCard(context, "ساحة الألعاب الذهنية", "قريباً..", Icons.extension, Colors.redAccent, const GameWorld()),
        ],
      ),
    );
  }

  Widget _buildCard(context, title, sub, icon, color, target) => Card(
    margin: const EdgeInsets.only(bottom: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: color.withOpacity(0.3))),
    color: const Color(0xFF161B22),
    child: InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(width: 20),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ])),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ]),
      ),
    ),
  );
}

// === عالم الترجمة المطور (النسخة الكاملة) ===
class VoiceWorld extends StatefulWidget {
  const VoiceWorld({super.key});
  @override State<VoiceWorld> createState() => _VoiceWorldState();
}
class _VoiceWorldState extends State<VoiceWorld> {
  final TextEditingController _in = TextEditingController();
  String _out = "الترجمة...";
  String _f = 'ar'; String _t = 'en'; bool _l = false;

  Future<void> _tr() async {
    if(_in.text.isEmpty) return;
    setState(()=>_l=true);
    try {
      final res = await http.get(Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=$_f&tl=$_t&dt=t&q=${Uri.encodeComponent(_in.text)}'));
      setState(()=>_out=json.decode(res.body)[0][0][0]);
    } catch(e){_out="خطأ اتصال";}
    setState(()=>_l=false);
  }

  void _copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم النسخ ✅")));
  }

  void _paste() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null) setState(() => _in.text = data.text!);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("الترجمة والحديث الثنائي")),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        // اختيار اللغات
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DropdownButton<String>(value: _f, items: const [DropdownMenuItem(value: 'ar', child: Text("العربية")), DropdownMenuItem(value: 'en', child: Text("الإنجليزية"))], onChanged: (v)=>setState(()=>_f=v!)),
            IconButton(icon: const Icon(Icons.swap_horiz, color: Colors.blueAccent), onPressed: (){ setState((){ String temp=_f; _f=_t; _t=temp; }); }),
            DropdownButton<String>(value: _t, items: const [DropdownMenuItem(value: 'ar', child: Text("العربية")), DropdownMenuItem(value: 'en', child: Text("الإنجليزية"))], onChanged: (v)=>setState(()=>_t=v!)),
          ]),
        ),
        const SizedBox(height: 20),
        // صندوق الإدخال مع أزرار التحكم
        Stack(children: [
          TextField(controller: _in, maxLines: 5, decoration: InputDecoration(hintText: "تحدث أو اكتب هنا...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)), filled: true, fillColor: Colors.white.withOpacity(0.05))),
          Positioned(bottom: 5, right: 5, child: Row(children: [
            IconButton(icon: const Icon(Icons.paste, size: 20), onPressed: _paste),
            IconButton(icon: const Icon(Icons.mic, color: Colors.redAccent), onPressed: (){}),
          ])),
        ]),
        const SizedBox(height: 15),
        ElevatedButton.icon(onPressed: _tr, icon: _l ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.translate), label: const Text("ترجمة فورية"), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
        const SizedBox(height: 20),
        // صندوق المخرجات
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.blue.withOpacity(0.3))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(_out, style: const TextStyle(fontSize: 20, color: Colors.cyanAccent, fontWeight: FontWeight.w500)),
            const Divider(color: Colors.white10, height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(icon: const Icon(Icons.volume_up, color: Colors.white70), onPressed: (){}),
              IconButton(icon: const Icon(Icons.copy, color: Colors.white70), onPressed: () => _copy(_out)),
            ]),
          ]),
        ),
        const SizedBox(height: 30),
        const Text("💡 نصيحة أدهم: استخدم وضع الحديث الثنائي عند السفر!", style: TextStyle(color: Colors.grey, fontSize: 12)),
      ]),
    ),
  );
}

// === عالم العدسة (OCR) ===
class CameraWorld extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraWorld({super.key, required this.cameras});
  @override State<CameraWorld> createState() => _CameraWorldState();
}
class _CameraWorldState extends State<CameraWorld> {
  CameraController? _ctrl;
  @override void initState() { super.initState(); if(widget.cameras.isNotEmpty) { _ctrl = CameraController(widget.cameras[0], ResolutionPreset.high); _ctrl!.initialize().then((_) => setState(() {})); } }
  @override void dispose() { _ctrl?.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    if (_ctrl == null || !_ctrl!.value.isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(body: Stack(children: [CameraPreview(_ctrl!), Positioned(top: 40, left: 20, child: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: ()=>Navigator.pop(context)))]));
  }
}

class DocWorld extends StatelessWidget { const DocWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("المستندات"))); }
class StoryWorld extends StatelessWidget { const StoryWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("الإلهام"))); }
class GameWorld extends StatelessWidget { const GameWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("الألعاب"))); }
