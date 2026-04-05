import 'dart:convert';
import 'package:flutter/services.dart';

class InspirationManager {
  static Future<List<dynamic>> getAllStories() async {
    final String response = await rootBundle.loadString('assets/data/stories/main_stories.json');
    final data = json.decode(response);
    return data;
  }

  static Future<List<dynamic>> searchStories(String query) async {
    final List<dynamic> all = await getAllStories();
    return all.where((s) => 
      s['title'].toString().contains(query) || 
      s['content'].toString().contains(query)
    ).toList();
  }
}
