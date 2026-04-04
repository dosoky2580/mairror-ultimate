import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/translation_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Mairror Ultimate',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: TranslationScreen(), // البداية من شاشة الترجمة اللي جهزناها
    ),
  );
}
