import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MairrorApp());
}

class MairrorApp extends StatelessWidget {
  const MairrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '🛡️ Mairror Ultimate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
