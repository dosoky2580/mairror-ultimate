import 'package:flutter/material.dart';
import 'dart:math';

class InspirationScreen extends StatelessWidget {
  final List<String> items = ["حديث قدسي 1", "حديث قدسي 2", "رسالة تحفيزية"]; // سيتم ربطها بالـ JSON

  void showFullMessage(BuildContext context, String title) {
    String message = items[Random().nextInt(items.length)];
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(color: Colors.amber, fontSize: 18)),
                SizedBox(height: 20),
                Text(message, textAlign: TextAlign.center, 
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 40),
                ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("رجوع"))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ركن الإلهام')),
      body: Column(
        children: [
          ListTile(title: Text("الأحاديث القدسية"), leading: Icon(Icons.menu_book), onTap: () => showFullMessage(context, "حديث قدسي")),
          ListTile(title: Text("رسائل محفزة"), leading: Icon(Icons.bolt), onTap: () => showFullMessage(context, "رسالة لك")),
        ],
      ),
    );
  }
}
