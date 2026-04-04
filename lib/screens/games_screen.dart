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
            const Icon(Icons.grid_on, size: 100, color: Colors.amber),
            const SizedBox(height: 20),
            const Text('شطرنج ميرور - محرك 0.8.1', 
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('جاري تهيئة الرقعة الذكية...', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.amber),
          ],
        ),
      ),
    );
  }
}
