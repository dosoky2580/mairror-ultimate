import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

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
        title: const Text("🛡️ MIRROR ULTIMATE", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildCard(context, "عالم الترجمة الفورية", "صوت، مشاركة، وحذف تلقائي", Icons.translate, Colors.blue, const TranslationWorld()),
          _buildCard(context, "الترجمة الثنائية", "حوار طرفين (قريباً)", Icons.people, Colors.orange, const DualChatWorld()),
          _buildCard(context, "عالم العدسة الذكية", "رؤية وترجمة حية", Icons.remove_red_eye, Colors.amber, const Placeholder("العدسة")),
        ],
      ),
    );
  }

  Widget _buildCard(context, title, sub, icon, color, target) => Card(
    margin: const EdgeInsets.only(bottom: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: color.withOpacity(0.2))),
    color: const Color(0xFF161B22),
    child: ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
    ),
  );
}

class TranslationWorld extends StatefulWidget {
  const TranslationWorld({super.key});
  @override State<TranslationWorld> createState() => _TranslationWorldState();
}

class _TranslationWorldState extends State<TranslationWorld> {
  final TextEditingController _in = TextEditingController();
  String _out = "الترجمة هنا...";
  bool _loading = false;

  Future<void> _translate() async {
    if (_in.text.isEmpty) return;
    setState(() => _loading = true);
    try {
      final res = await http.get(Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en&dt=t&q=${Uri.encodeComponent(_in.text)}'));
      setState(() => _out = json.decode(res.body)[0][0][0]);
    } catch (e) { setState(() => _out = "خطأ اتصال"); }
    setState(() => _loading = false);
  }

  Future<void> _shareAndClean() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/mirror_msg.txt'); // مؤقتاً ملف نصي حتى نربط محرك الصوت
    await file.writeAsString(_out);
    
    await Share.shareXFiles([XFile(file.path)], text: 'مترجم من ميرور ألتيميت');
    
    if (await file.exists()) await file.delete(); // الحذف التلقائي فوراً
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("محرك الترجمة")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: _in, maxLines: 4, decoration: const InputDecoration(hintText: "اكتب هنا...", border: OutlineInputBorder())),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _translate, child: _loading ? const CircularProgressIndicator() : const Text("ترجمة الملحمة")),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Text(_out, style: const TextStyle(fontSize: 18, color: Colors.cyanAccent)),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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

class DualChatWorld extends StatelessWidget {
  const DualChatWorld({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("حوار الطرفين")), body: const Center(child: Text("جاري ضبط وضع الحوار...")));
}

class Placeholder extends StatelessWidget {
  final String name;
  const Placeholder(this.name, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(), body: Center(child: Text("عالم $name قريباً")));
}
