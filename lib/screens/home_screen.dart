import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // كارت الإلهام اليومي (أحاديث/حكم)
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const ListTile(
              leading: Icon(Icons.auto_awesome, color: Colors.cyan),
              title: Text('إلهام اليوم 🌙'),
              subtitle: Text('"إنما الأعمال بالنيات.." - حديث شريف'),
            ),
          ),
          const SizedBox(height: 20),
          
          // حقل إدخال النص للترجمة
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'اكتب الكلمات التركية هنا..',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _controller.clear(),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // أزرار التحكم في الترجمة والصوت
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // هنا هنربط محرك ML Kit قريباً
                  context.read<AppProvider>().translate(_controller.text);
                },
                icon: const Icon(Icons.translate),
                label: const Text('ترجم فوراً'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan[700], foregroundColor: Colors.white),
              Consumer<AppProvider>(builder: (context, provider, _) => provider.isTranslating ? const CircularProgressIndicator() : Text(provider.translatedText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              ),
              CircleAvatar(
                backgroundColor: Colors.cyan[100],
                child: IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.cyan),
                  onPressed: () {
                    // هنا هنربط الـ TTS (أصوات سيف وسلمى)
                    print("نطق النص...");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
