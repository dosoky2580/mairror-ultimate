import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('🛡️ MAIRROR ULTIMATE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () => _openPage(context, 'الإعدادات والتحكم'),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildCard(context, 'الترجمة الفورية', Icons.translate, Colors.blue),
            _buildCard(context, 'عدسة ميرور (AI)', Icons.camera_alt, Colors.amber),
            _buildCard(context, 'الكتب والمستندات', Icons.menu_book, Colors.green),
            _buildCard(context, 'ساحة الألعاب', Icons.sports_esports, Colors.red),
            _buildCard(context, 'قصص وإلهام', Icons.auto_stories, Colors.purple),
            _buildCard(context, 'مساعد أدهم', Icons.smart_toy, Colors.teal),
          ],
        ),
      ),
    );
  }

  void _openPage(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('جاري تفعيل ركن: $title بأسلوب مثالي...')),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _openPage(context, title),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: color),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, 
                 style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
