import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
        primaryColor: Colors.blueAccent,
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
        title: const Text("🛡️ MIRROR ULTIMATE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildWorldCard(context, "عالم الترجمة الفورية", "ترجمة صوتية ونصية بـ 5 أصوات احترافية", Icons.translate, Colors.blue, const VoiceWorld()),
          _buildWorldCard(context, "عالم العدسة الذكية", "رؤية العالم وترجمة النصوص حياً", Icons.remove_red_eye, Colors.amber, CameraWorld(cameras: cameras)),
          _buildWorldCard(context, "عالم المستندات والـ PDF", "تحويل الأوراق لعالم رقمي مترجم", Icons.copy_all, Colors.green, const DocWorld()),
          _buildWorldCard(context, "عالم الإلهام والقصص", "قصص الأنبياء والصحابة بمؤثرات صوتية", Icons.auto_stories, Colors.purple, const StoryWorld()),
          _buildWorldCard(context, "ساحة الألعاب الذهنية", "تحديات الشطرنج ومكعب روبيك الذكي", Icons.extension, Colors.redAccent, const GameWorld()),
        ],
      ),
    );
  }

  Widget _buildWorldCard(context, title, sub, icon, color, Widget target) => Card(
    margin: const EdgeInsets.only(bottom: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

// --- العوالم (الأركان) ---
class VoiceWorld extends StatelessWidget { const VoiceWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("عالم الترجمة")), body: const Center(child: Text("محرك الصوت جاهز"))); }
class DocWorld extends StatelessWidget { const DocWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("عالم المستندات")), body: const Center(child: Text("مترجم الـ PDF جاهز"))); }
class StoryWorld extends StatelessWidget { const StoryWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("عالم الإلهام")), body: const Center(child: Text("القصص والمؤثرات جاهزة"))); }
class GameWorld extends StatelessWidget { const GameWorld({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("ساحة الألعاب")), body: const Center(child: Text("الألعاب الذكية جاهزة"))); }

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
