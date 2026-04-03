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
        appBar: AppBar(title: const Text("Mirror - ركن الترجمة")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // اختيار الصوت
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
                decoration: const InputDecoration(hintText: "اكتب هنا..."),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              if (provider.isWorking) const LinearProgressIndicator(),
              Container(
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
}
