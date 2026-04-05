import 'package:flutter/material.dart';
import 'vision_screen.dart';
import 'library_screen.dart';
import 'translation_screen.dart';
import 'inspiration_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🛡️ Mairror Ultimate")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          _buildCard(context, 'المترجم الفوري', Icons.translate, Colors.blue, TranslationScreen()),
          _buildCard(context, 'عدسة ميرور (AI)', Icons.camera_alt, Colors.amber, VisionScreen()),
          _buildCard(context, 'الكتب والمستندات', Icons.menu_book, Colors.green, LibraryScreen()),
          _buildCard(context, 'ركن الإلهام', Icons.auto_stories, Colors.purple, InspirationScreen()),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, Widget screen) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
