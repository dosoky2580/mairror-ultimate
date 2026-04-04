import 'package:flutter/material.dart';

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
            icon: const Icon(Icons.settings, color: Colors.grey),
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
              const SizedBox(height: 100), // مسافة للـ AppBar
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildFloatingCard(context, 'الترجمة الفورية', Icons.translate, Colors.blue, 'translation'),
                    _buildFloatingCard(context, 'عدسة ميرور (AI)', Icons.camera_alt, Colors.amber, 'vision'),
                    _buildFloatingCard(context, 'الكتب والمستندات', Icons.menu_book, Colors.green, 'library'),
                    _buildFloatingCard(context, 'ساحة الألعاب', Icons.sports_esports, Colors.red, 'games'),
                    _buildFloatingCard(context, 'قصص وإلهام', Icons.auto_stories, Colors.purple, 'stories'),
                    _buildFloatingCard(context, 'مساعد أدهم', Icons.smart_toy, Colors.teal, 'adharn'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPage(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('جاري تفعيل ركن: $title بأسلوب مثالي...')),
    );
  }

  Widget _buildFloatingCard(BuildContext context, String title, IconData icon, Color color, String type) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
        boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _openPage(context, title),
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
      ),
    );
  }
}
