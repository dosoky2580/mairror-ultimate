import 'package:flutter/material.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {'title': 'قصص الأنبياء', 'icon': '🌙'},
      {'title': 'قصص الحيوان في القرآن', 'icon': '🐘'},
      {'title': 'قصص النساء في القرآن', 'icon': '👸'},
      {'title': 'عجائب القصص', 'icon': '✨'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('ركن الإلهام والقصص')),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF1D1E33),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: Text(stories[index]['icon']!, style: const TextStyle(fontSize: 30)),
              title: Text(stories[index]['title']!, style: const TextStyle(color: Colors.white)),
              subtitle: const Text('استمع بصوت سيف أو سارة مع مؤثرات طبيعية', style: TextStyle(color: Colors.grey, fontSize: 12)),
              trailing: const Icon(Icons.play_circle_fill, color: Colors.purple, size: 35),
              onTap: () {
                // منطق تشغيل القصة بالصوت والمؤثرات
              },
            ),
          );
        },
      ),
    );
  }
}
