import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MairrorUltimateApp());
}

class MairrorUltimateApp extends StatelessWidget {
  const MairrorUltimateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E14),
        primaryColor: Colors.blueAccent,
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
        title: const Text("🛡️ MIRROR ULTIMATE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildFeatureCard(context, "عالم الترجمة الفورية", "صوت ونص (5 أصوات)", Icons.translate, Colors.blue, const FullTranslationWorld()),
          _buildFeatureCard(context, "الترجمة الثنائية", "حوار بين طرفين", Icons.people, Colors.orange, const DualChatWorld()),
          _buildFeatureCard(context, "عالم العدسة الذكية", "رؤية وترجمة حية", Icons.remove_red_eye, Colors.amber, const PlaceholderWorld("العدسة")),
          _buildFeatureCard(context, "عالم المستندات والـ PDF", "ترجمة الأوراق والملفات", Icons.copy_all, Colors.green, const PlaceholderWorld("المستندات")),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(context, title, sub, icon, color, target) => Card(
    margin: const EdgeInsets.only(bottom: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: color.withOpacity(0.2))),
    color: const Color(0xFF161B22),
    child: ListTile(
      contentPadding: const EdgeInsets.all(15),
      leading: Icon(icon, size: 35, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
    ),
  );
}

// === ركن الترجمة الشامل (المايك، النطق، المشاركة) ===
class FullTranslationWorld extends StatefulWidget {
  const FullTranslationWorld({super.key});
  @override State<FullTranslationWorld> createState() => _FullTranslationWorldState();
}

class _FullTranslationWorldState extends State<FullTranslationWorld> {
  final TextEditingController _controller = TextEditingController();
  String _result = "الترجمة ستظهر هنا...";
  bool _isTranslating = false;

  Future<void> _translate() async {
    if (_controller.text.isEmpty) return;
    setState(() => _isTranslating = true);
    try {
      final res = await http.get(Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en&dt=t&q=${Uri.encodeComponent(_controller.text)}'));
      setState(() => _result = json.decode(res.body)[0][0][0]);
    } catch (e) {
      setState(() => _result = "خطأ في الاتصال");
    }
    setState(() => _isTranslating = false);
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _result));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم نسخ النص ✅")));
  }

  // محاكاة مشاركة ملف صوتي مع حذف تلقائي
  Future<void> _shareVoice() async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/mirror_voice.mp3');
    await file.writeAsString("voice_data_dummy"); // محاكاة لبيانات الصوت
    
    await Share.shareXFiles([XFile(file.path)], text: 'رسالة صوتية من ميرور');
    
    // الحذف التلقائي بعد المشاركة
    if (await file.exists()) {
      await file.delete();
      print("تم حذف الملف الصوتي تلقائياً لخصوصيتك.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("محرك الترجمة العالمي")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "اكتب أو استخدم المايك...",
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              suffixIcon: IconButton(icon: const Icon(Icons.mic, color: Colors.redAccent), onPressed: () {}),
            ),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton.icon(onPressed: _translate, icon: const Icon(Icons.translate), label: const Text("ترجمة الملحمة")),
            IconButton(icon: const Icon(Icons.paste), onPressed: () async {
              var data = await Clipboard.getData('text/plain');
              if (data != null) _controller.text = data.text!;
            }),
          ]),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_result, style: const TextStyle(fontSize: 18, color: Colors.cyanAccent)),
              const Divider(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
                IconButton(icon: const Icon(Icons.copy), onPressed: _copyToClipboard),
                IconButton(icon: const Icon(Icons.share), onPressed: _shareVoice),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

// === وضع الترجمة الثنائية (حوار طرفين) ===
class DualChatWorld extends StatelessWidget {
  const DualChatWorld({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الحديث الثنائي")),
      body: Column(children: [
        Expanded(child: Container(
          color: Colors.blue.withOpacity(0.05),
          child: const Center(child: Text("الطرف الأول (اضغط للتحدث)", style: TextStyle(color: Colors.blue))),
        )),
        const Divider(height: 2, color: Colors.white24),
        Expanded(child: Container(
          color: Colors.green.withOpacity(0.05),
          child: const Center(child: Text("الطرف الثاني (اضغط للتحدث)", style: TextStyle(color: Colors.green))),
        )),
      ]),
    );
  }
}

class PlaceholderWorld extends StatelessWidget {
  final String name;
  const PlaceholderWorld(this.name, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(), body: Center(child: Text("قريباً: عالم $name")));
}
