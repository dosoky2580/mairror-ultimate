import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MairrorUltimateApp());
}

class MairrorUltimateApp extends StatelessWidget {
  const MairrorUltimateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E14),
      ),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🛡️ MIRROR ULTIMATE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildCard(context, "عالم الترجمة الفورية", "صوت، لغات، مشاركة، وحذف", Icons.translate, Colors.blue, const VoiceWorld()),
          _buildCard(context, "عالم العدسة الذكية", "رؤية وترجمة حية (OCR)", Icons.remove_red_eye, Colors.amber, const Placeholder("عالم العدسة")),
          _buildCard(context, "عالم المستندات والـ PDF", "ترجمة وتحويل الملفات", Icons.copy_all, Colors.green, const Placeholder("عالم المستندات")),
          _buildCard(context, "عالم الإلهام والقصص", "قصص دينية بمؤثرات صوتية", Icons.auto_stories, Colors.purple, const Placeholder("عالم القصص")),
          _buildCard(context, "ساحة الألعاب الذهنية", "شطرنج ومكعب روبيك 3D", Icons.extension, Colors.redAccent, const Placeholder("ساحة الألعاب")),
        ],
      ),
    );
  }

  Widget _buildCard(context, title, sub, icon, color, target) => Card(
    margin: const EdgeInsets.only(bottom: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: color.withOpacity(0.3))),
    color: const Color(0xFF161B22),
    child: ListTile(
      contentPadding: const EdgeInsets.all(20),
      leading: Icon(icon, color: color, size: 40),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
    ),
  );
}

class VoiceWorld extends StatefulWidget {
  const VoiceWorld({super.key});
  @override State<VoiceWorld> createState() => _VoiceWorldState();
}

class _VoiceWorldState extends State<VoiceWorld> {
  final TextEditingController _in = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  
  String _out = "الترجمة ستظهر هنا...";
  String _from = 'ar';
  String _to = 'en';
  bool _isListening = false;
  bool _loading = false;

  final Map<String, String> _langs = {'ar': 'العربية', 'en': 'الإنجليزية', 'fr': 'الفرنسية', 'tr': 'التركية', 'de': 'الألمانية'};

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) => setState(() => _in.text = val.recognizedWords));
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _speak(String text) async {
    await _tts.setLanguage(_to);
    await _tts.speak(text);
  }

  Future<void> _translate() async {
    if (_in.text.isEmpty) return;
    setState(() => _loading = true);
    try {
      final res = await http.get(Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=$_from&tl=$_to&dt=t&q=${Uri.encodeComponent(_in.text)}'));
      setState(() => _out = json.decode(res.body)[0][0][0]);
    } catch (e) { setState(() => _out = "خطأ في الاتصال"); }
    setState(() => _loading = false);
  }

  Future<void> _shareAndClean() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/mirror_voice.txt');
    await file.writeAsString(_out);
    await Share.shareXFiles([XFile(file.path)], text: 'مترجم بواسطة ميرور');
    if (await file.exists()) await file.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("محرك الترجمة العالمي")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            DropdownButton<String>(value: _from, items: _langs.entries.map((e)=>DropdownMenuItem(value: e.key, child: Text(e.value))).toList(), onChanged: (v)=>setState(()=>_from=v!)),
            IconButton(icon: const Icon(Icons.swap_horiz, color: Colors.blueAccent), onPressed: () => setState(() { String t = _from; _from = _to; _to = t; })),
            DropdownButton<String>(value: _to, items: _langs.entries.map((e)=>DropdownMenuItem(value: e.key, child: Text(e.value))).toList(), onChanged: (v)=>setState(()=>_to=v!)),
          ]),
          const SizedBox(height: 20),
          Stack(alignment: Alignment.bottomRight, children: [
            TextField(controller: _in, maxLines: 5, decoration: InputDecoration(hintText: "اكتب أو تحدث...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)), filled: true, fillColor: Colors.white10)),
            IconButton(icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.redAccent), onPressed: _listen),
          ]),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: _translate, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)), child: _loading ? const CircularProgressIndicator() : const Text("ترجمة فورية")),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.blue.withOpacity(0.3))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_out, style: const TextStyle(fontSize: 20, color: Colors.cyanAccent)),
              const Divider(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(icon: const Icon(Icons.volume_up), onPressed: () => _speak(_out)),
                IconButton(icon: const Icon(Icons.copy), onPressed: () => Clipboard.setData(ClipboardData(text: _out))),
                IconButton(icon: const Icon(Icons.share), onPressed: _shareAndClean),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  final String name;
  const Placeholder(this.name, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(name)), body: Center(child: Text("$name سيعود قريباً بتصميم أدهم")));
}
