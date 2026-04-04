import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('ساحة الألعاب الذكية')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _gameTile('3D Chess (الشطرنج)', Icons.grid_on, Colors.white),
            const SizedBox(height: 20),
            _gameTile('Rubik\'s Cube (مكعب روبيك)', Icons.view_in_ar, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _gameTile(String title, IconData icon, Color color) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1D1E33), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(width: 20),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
