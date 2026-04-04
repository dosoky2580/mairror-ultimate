import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الإعدادات')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('الوضع المظلم'),
            value: true, // مفعل افتراضياً
            onChanged: (bool value) {},
            secondary: Icon(Icons.dark_mode),
          ),
          ListTile(
            title: Text('نبذة عن المطور'),
            subtitle: Text('Tamer - Developer of Mirror Ultimate\nProject Heart: Adham'),
            leading: Icon(Icons.info),
          ),
          ListTile(
            title: Text('إصدار التطبيق'),
            subtitle: Text('2.1.0 (Build 101)'),
            leading: Icon(Icons.verified),
          ),
        ],
      ),
    );
  }
}
