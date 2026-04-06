import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// Note: Keeping other imports for future integration
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = [];
  try {
    cameras = await availableCameras();
  } catch (e) {
    print("Camera error: $e");
  }
  runApp(MairrorUltimateApp(cameras: cameras));
}

class MairrorUltimateApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MairrorUltimateApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Dark Background
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
        title: const Text("🛡️ Mairror Ultimate", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Text("اختر عالمك للبدء", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 25),
            
            // --- الأركان تحت بعض (List Item Style) ---
            _buildListTile(context, "الترجمة الذكية (STT/TTS)", Icons.translate, Colors.blueAccent, 
              const VoiceTransScreen()),
            _buildListTile(context, "عدسة ميرور (AI Runtimes)", Icons.camera_enhance, Colors.amber, 
              CameraLensScreen(cameras: cameras)),
            _buildListTile(context, "الكتب والمستندات (PDF/OCR)", Icons.description, Colors.greenAccent, 
              const LibraryScreen()),
            _buildListTile(context, "ركن الإلهام الصوفي (Voices)", Icons.auto_awesome, Colors.purpleAccent, 
              const InspirationScreen()),
            _buildListTile(context, "ساحة الألعاب الذكية (Chess)", Icons.sports_esports, Colors.redAccent, 
              const GamesScreen()),
          ],
        ),
      ),
    );
  }

  // ويدجت احترافية لعرض العنصر في قائمة
  Widget _buildListTile(context, title, icon, color, Widget screen) => Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10),
    color: const Color(0xFF1E293B), // Darker Gray for Tiles
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.2), width: 1)),
    child: InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
              child: Icon(icon, size: 40, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 20),
          ],
        ),
      ),
    ),
  );
}

// === شاشات افتراضية (هياكل) عشان التصفح يشتغل ===

class LibraryScreen extends StatelessWidget { const LibraryScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("الكتب والمستندات")), body: Center(child: Text("جاري تطوير المكتبة", style: TextStyle(color: Colors.white, fontSize: 20)))); }
class InspirationScreen extends StatelessWidget { const InspirationScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("ركن الإلهام")), body: Center(child: Text("جاري تحضير الإلهام", style: TextStyle(color: Colors.white, fontSize: 20)))); }
class GamesScreen extends StatelessWidget { const GamesScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("ساحة الألعاب")), body: Center(child: Text("جاري تهيئة الرقعة", style: TextStyle(color: Colors.white, fontSize: 20)))); }
class VoiceTransScreen extends StatelessWidget { const VoiceTransScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("الترجمة")), body: Center(child: Text("جاري ربط المحرك", style: TextStyle(color: Colors.white, fontSize: 20)))); }

class CameraLensScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraLensScreen({super.key, required this.cameras});
  @override State<CameraLensScreen> createState() => _CameraLensState();
}
class _CameraLensState extends State<CameraLensScreen> {
  CameraController? _ctrl;
  @override void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) {
      _ctrl = CameraController(widget.cameras[0], ResolutionPreset.max);
      _ctrl!.initialize().then((_) => setState(() {}));
    }
  }
  @override void dispose() { _ctrl?.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    if (_ctrl == null || !_ctrl!.value.isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(body: Stack(children: [CameraPreview(_ctrl!), Positioned(top: 40, left: 20, child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)))]));
  }
}
