import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mairror_ultimate/providers/app_provider.dart';

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
            _buildMainButton(context, "ركن الترجمة", Icons.translate, () => _openTranslate(context)),
            const SizedBox(height: 20),
            _buildMainButton(context, "حديث بين طرفين", Icons.people, () {}), // للنسخة القادمة
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
          SwitchListTile(title: const Text("الوضع المظلم"), value: provider.isDarkMode, onChanged: (v) => provider.toggleTheme()),
          ListTile(
            title: const Text("صوت المترجم"),
            trailing: DropdownButton<String>(
              value: provider.selectedVoice,
              onChanged: (v) => provider.setVoice(v!),
              items: provider.voiceNames.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
          ),
          ListTile(title: const Text("نبذة عن المطور"), leading: const Icon(Icons.info), onTap: () {}),
          ListTile(title: const Text("تيتو كولكشن واى"), leading: const Icon(Icons.shopping_bag), onTap: () {}),
        ],
      ),
    );
  }

  void _openTranslate(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const TranslatePage()));
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
          TextField(controller: controller, decoration: const InputDecoration(hintText: "اكتب هنا...")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => provider.translate(controller.text), child: const Text("ترجم وانطق")),
          const SizedBox(height: 20),
          Text(provider.resultText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
