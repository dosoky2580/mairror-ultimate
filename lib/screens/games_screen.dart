import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as chess;

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
            const Icon(Icons.grid_on, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text('شطرنج ميرور (Logic 0.8.1)', 
                style: TextStyle(color: Colors.amber, fontSize: 18)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {}, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('ابدأ تحدي الذكاء الاصطناعي'),
            ),
          ],
        ),
      ),
    );
  }
}
