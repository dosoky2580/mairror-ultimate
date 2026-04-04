import 'package:flutter/material.dart';
import '../logic/adham_brain.dart';

class AdharnAssistantScreen extends StatelessWidget {
  const AdharnAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('مساعد أدهم')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.psychology, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              Text(
                AdhamBrain.getWelcomeMessage(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 30),
              _statusTile('حماية AES-256', Icons.verified_user, Colors.green),
              _statusTile('تنسيق A4 الذكي', Icons.print, Colors.blue),
              _statusTile('وضع الأوفلاين', Icons.wifi_off, Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusTile(String title, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
    );
  }
}
