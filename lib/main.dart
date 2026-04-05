import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MirrorUltimate());
}

class MirrorUltimate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirror Ultimate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        fontFamily: 'Tajawal',
      ),
      home: HomeScreen(), // شيلنا الـ const من هنا عشان الطريق يفتح
    );
  }
}
