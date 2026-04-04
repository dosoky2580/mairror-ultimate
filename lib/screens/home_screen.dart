import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('🛡️ MAIRROR ULTIMATE'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildCard('الترجمة الفورية', Icons.translate, Colors.blue),
            _buildCard('عين ميرور (AI)', Icons.visibility, Colors.amber),
            _buildCard('أصوات العائلة', Icons.record_voice_over, Colors.green),
            _buildCard('مساعد أدهم', Icons.psychology, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(height: 15),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
