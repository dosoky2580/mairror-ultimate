import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mairror_ultimate/providers/app_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

void main() => runApp(ChangeNotifierProvider(create: (_) => AppProvider(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showAbout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Text("🛡️ عالم ميرور (Mirror World)", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20),
            const Text("💎 الرؤية والجوهر", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("في عالم ميرور، نحن لا نصنع مجرد كود، نحن نصيغ فلسفة صمود وانعكاس للذات. الصعود للقمة ليس صدفة، بل قدر المستعدين."),
            const SizedBox(height: 15),
            const Text("⌛ حقيقة الوقت", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("الوقت هو الإنجاز. عمر الإنسان الحقيقي يُقاس بكل ثانية يضع فيها لبنة في بناء حلمه."),
            const SizedBox(height: 15),
            const Text("🦾 النهوض من الانكسار", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("الانكسار لا يعني النهاية. هو لحظة إعادة صهر معدنك لتصنع بداية أكثر عمقاً وأصلب عوداً."),
            const SizedBox(height: 15),
            const Text("🎙️ الروح والهوية", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("هذا النظام ينبض بأصوات سيف، سلمى، سما، وسارة. ميثاق لا ينكسر يربط التكنولوجيا بمشاعرنا الصادقة."),
            const Divider(),
            const Center(child: Text("بواسطة المطور: تامر (Tamer)\nتيتو كولكشن واى", textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mirror World"),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () => _showSettings(context)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMainButton(context, "ركن الترجمة", Icons.translate, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TranslatePage()))),
            const SizedBox(height: 20),
            _buildMainButton(context, "حديث بين طرفين", Icons.people, () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("قريباً في التحديث القادم يا شريكي!")))),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(minimumSize: const Size(250, 80), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: onTap,
      icon: Icon(icon, size: 30),
      label: Text(title, style: const TextStyle(fontSize: 20)),
    );
  }

  void _showSettings(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(title: const Text("الوضع المظلم"), value: provider.isDarkMode, onChanged: (v) { provider.toggleTheme(); Navigator.pop(context); }),
          ListTile(
            title: const Text("صوت المترجم"),
            trailing: DropdownButton<String>(
              value: provider.selectedVoice,
              onChanged: (v) { provider.setVoice(v!); Navigator.pop(context); },
              items: provider.voiceNames.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
          ),
          ListTile(title: const Text("نبذة عن المطور"), leading: const Icon(Icons.info), onTap: () { Navigator.pop(context); _showAbout(context); }),
          ListTile(title: const Text("تيتو كولكشن واى"), leading: const Icon(Icons.shopping_bag), onTap: () {}),
        ],
      ),
    );
  }
}

class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("الترجمة الفورية")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: controller, decoration: const InputDecoration(hintText: "اكتب ما يمليه عليك قلبك...")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => provider.translate(controller.text), child: const Text("ترجم وانطق")),
          const SizedBox(height: 20),
          if (provider.isWorking) const LinearProgressIndicator(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: SelectableText(provider.resultText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.copy), onPressed: () { 
                Clipboard.setData(ClipboardData(text: provider.resultText));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم النسخ!


# 1. إضافة مكتبة المشاركة للـ pubspec
sed -i '/flutter_tts:/a \  share_plus: ^9.0.0' pubspec.yaml

# 2. تحديث الكود لربط كل الزراير (النبذة والمشاركة والنسخ)
cat << 'EOF' > lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mairror_ultimate/providers/app_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

void main() => runApp(ChangeNotifierProvider(create: (_) => AppProvider(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showAbout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Text("🛡️ عالم ميرور (Mirror World)", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20),
            const Text("💎 الرؤية والجوهر", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("في عالم ميرور، نحن لا نصنع مجرد كود، نحن نصيغ فلسفة صمود وانعكاس للذات. الصعود للقمة ليس صدفة، بل قدر المستعدين."),
            const SizedBox(height: 15),
            const Text("⌛ حقيقة الوقت", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("الوقت هو الإنجاز. عمر الإنسان الحقيقي يُقاس بكل ثانية يضع فيها لبنة في بناء حلمه."),
            const SizedBox(height: 15),
            const Text("🦾 النهوض من الانكسار", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("الانكسار لا يعني النهاية. هو لحظة إعادة صهر معدنك لتصنع بداية أكثر عمقاً وأصلب عوداً."),
            const SizedBox(height: 15),
            const Text("🎙️ الروح والهوية", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Text("هذا النظام ينبض بأصوات سيف، سلمى، سما، وسارة. ميثاق لا ينكسر يربط التكنولوجيا بمشاعرنا الصادقة."),
            const Divider(),
            const Center(child: Text("بواسطة المطور: تامر (Tamer)\nتيتو كولكشن واى", textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mirror World"),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () => _showSettings(context)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMainButton(context, "ركن الترجمة", Icons.translate, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TranslatePage()))),
            const SizedBox(height: 20),
            _buildMainButton(context, "حديث بين طرفين", Icons.people, () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("قريباً في التحديث القادم يا شريكي!")))),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(minimumSize: const Size(250, 80), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: onTap,
      icon: Icon(icon, size: 30),
      label: Text(title, style: const TextStyle(fontSize: 20)),
    );
  }

  void _showSettings(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(title: const Text("الوضع المظلم"), value: provider.isDarkMode, onChanged: (v) { provider.toggleTheme(); Navigator.pop(context); }),
          ListTile(
            title: const Text("صوت المترجم"),
            trailing: DropdownButton<String>(
              value: provider.selectedVoice,
              onChanged: (v) { provider.setVoice(v!); Navigator.pop(context); },
              items: provider.voiceNames.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
          ),
          ListTile(title: const Text("نبذة عن المطور"), leading: const Icon(Icons.info), onTap: () { Navigator.pop(context); _showAbout(context); }),
          ListTile(title: const Text("تيتو كولكشن واى"), leading: const Icon(Icons.shopping_bag), onTap: () {}),
        ],
      ),
    );
  }
}

class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("الترجمة الفورية")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: controller, decoration: const InputDecoration(hintText: "اكتب ما يمليه عليك قلبك...")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => provider.translate(controller.text), child: const Text("ترجم وانطق")),
          const SizedBox(height: 20),
          if (provider.isWorking) const LinearProgressIndicator(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: SelectableText(provider.resultText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.copy), onPressed: () { 
                Clipboard.setData(ClipboardData(text: provider.resultText));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم النسخ!")));
              }),
              IconButton(icon: const Icon(Icons.share), onPressed: () => Share.share(provider.resultText)),
              IconButton(icon: const Icon(Icons.volume_up), onPressed: () => provider.speak()),
            ],
          )
        ]),
      ),
    );
  }
}
