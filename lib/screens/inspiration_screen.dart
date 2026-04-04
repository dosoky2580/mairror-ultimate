import 'package:flutter/material.dart';

class InspirationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Center(
        child: Text('🌟 ركن الإلهام\nقريباً: قصص وأحاديث بالذكاء الاصطناعي', 
        textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
