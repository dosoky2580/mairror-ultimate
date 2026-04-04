import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'translation_screen.dart';
import 'vision_screen.dart';
import 'library_screen.dart';
import 'stories_screen.dart';
import 'games_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('🛡️ MAIRROR ULTIMATE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1547234935-80c7145ec969'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildCard(context, 'الترجمة الفورية', Icons.translate, Colors.blue, TranslationScreen()),
                    _buildCard(context, 'عدسة ميرور (AI)', Icons.camera_alt, Colors.amber, const VisionScreen()),
                    _buildCard(context, 'الكتب والمستندات', Icons.menu_book, Colors.green, const LibraryScreen()),
                    _buildCard(context, 'ساحة الألعاب', Icons.sports_esports, Colors.red, const GamesScreen()),
                    _buildCard(context, 'قصص وإلهام', Icons.auto_stories, Colors.purple, const StoriesScreen()),
                    _buildCard(context, 'مساعد أدهم', Icons.smart_toy, Colors.teal, null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, Widget? page) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: color),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
