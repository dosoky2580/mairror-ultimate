import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🎮 ألعاب ميرور 3D')),
      body: Center(child: Text('جاري تحميل محرك الألعاب...')),
    );
  }
}
