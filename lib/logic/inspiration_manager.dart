import 'dart:convert';
import 'package:flutter/services.dart';

class InspirationManager {
  static Future<List<dynamic>> getAllStories() async {
    final String response = await rootBundle.loadString('assets/data/stories/main_stories.json');
    return json.decode(response);
  }
}
