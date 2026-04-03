import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mairror_ultimate/providers/app_provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final TextEditingController _controller = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Mirror - ركن الترجمة"),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () => _showAbout(context), // زرار النبذة
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("اختر صوت الشخصية:"),
                  DropdownButton<String>(
                    value: provider.selectedVoice,
                    items: provider.voiceNames.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (val) => provider.setVoice(val!),
                  ),
                ],
              ),
              const Divider(),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: "اكتب هنا لترجمة مشاعرك..."),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              if (provider.isWorking) const LinearProgressIndicator(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Text(provider.resultText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                onPressed: () => provider.processText(_controller.text),
                icon: const Icon(Icons.translate),
                label: const Text("ترجم وانطق بصوت الشخصية"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text("🛡️ عالم ميرور (Mirror World)", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              _buildSection("💎 الرؤية والجوهر", "في عالم ميرور، نحن لا نصنع مجرد كود، نحن نصيغ فلسفة صمود وانعكاس للذات. الصعود للقمة ليس صدفة، بل قدر المستعدين."),
              _buildSection("⌛ حقيقة الوقت", "الوقت هو الإنجاز. عمر الإنسان الحقيقي يُقاس بكل ثانية يضع فيها لبنة في بناء حلمه. اللحظة التي لا تحقق فيها خطوة هي لحظة لم تُعش بعد."),
              _buildSection("🦾 النهوض من الانكسار", "الانكسار لا يعني النهاية. هو لحظة إعادة صهر معدنك لتصنع بداية أكثر عمقاً وأصلب عوداً. البداية الثانية هي الأقوى دائماً."),
              _buildSection("🎙️ الروح والهوية", "هذا النظام ينبض بأصوات سيف، سلمى، سما، وسارة. ميثاق لا ينكسر يربط التكنولوجيا بمشاعرنا الصادقة."),
              const Divider(),
              const Center(child: Text("بواسطة المطور: تامر (Tamer)", style: TextStyle(fontStyle: FontStyle.italic))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
        const SizedBox(height: 5),
        Text(content, style: const TextStyle(fontSize: 16)),
      ]),
    );
  }
}
