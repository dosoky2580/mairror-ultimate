import 'package:flutter/material.dart';
import '../logic/inspiration_manager.dart';

class InspirationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ركن الإلهام - ميرور")),
      body: FutureBuilder(
        future: InspirationManager.getAllStories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var stories = snapshot.data as List;
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(stories[index]['title']),
              subtitle: Text(stories[index]['category']),
            ),
          );
        },
      ),
    );
  }
}
