import 'package:flutter/material.dart';

class TranslationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E), // اللون الغامق اللي بنحبه
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("المترجم الفوري الذكي", 
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Tajawal')),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {}, // هنا هنربط الصوت بعدين
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.tealAccent,
                    child: Icon(Icons.mic, size: 50, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
