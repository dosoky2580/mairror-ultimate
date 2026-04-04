import 'package:flutter/material.dart';
import 'dart:convert';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // محاكاة قراءة البيانات من ملف الـ JSON اللي صبناه في الـ Assets
    final List<Map<String, dynamic>> stories = [
      {"id": 1, "title": "قصة سيدنا يوسف", "category": "الأنبياء", "voice": "سيف", "icon": "🌙"},
      {"id": 2, "title": "هدهد سليمان", "category": "الحيوان في القرآن", "voice": "سارة", "icon": "🐘"},
      {"id": 3, "title": "سيدة نساء العالمين", "category": "النساء في القرآن", "voice": "سلمى", "icon": "👸"}
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('محراب القصص والإلهام')),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.purple.withOpacity(0.3)),
            ),
            child: ListTile(
              leading: Text(stories[index]['icon'], style: const TextStyle(fontSize: 25)),
              title: Text(stories[index]['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("بصمة صوت: ${stories[index]['voice']}", style: const TextStyle(color: Colors.amber, fontSize: 12)),
              trailing: const Icon(Icons.play_arrow_rounded, color: Colors.purple, size: 30),
              onTap: () {
                _showStoryPlaySheet(context, stories[index]['title'], stories[index]['voice']);
              },
            ),
          );
        },
      ),
    );
  }

  void _showStoryPlaySheet(BuildContext context, String title, String voice) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1D1E33),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("جاري التحميل بصوت $voice...", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const LinearProgressIndicator(color: Colors.purple),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.replay_10, color: Colors.white), onPressed: () {}),
                const Icon(Icons.pause_circle_filled, color: Colors.amber, size: 50),
                IconButton(icon: const Icon(Icons.forward_10, color: Colors.white), onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
