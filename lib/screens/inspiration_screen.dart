import 'package:flutter/material.dart';
import '../logic/inspiration_manager.dart';

class InspirationScreen extends StatefulWidget {
  @override
  _InspirationScreenState createState() => _InspirationScreenState();
}

class _InspirationScreenState extends State<InspirationScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A), // خلفية ليلية عميقة
      appBar: AppBar(
        title: Text('🌟 ركن الإلهام الأكبر'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "ابحث عن قصة، حكمة، أو عبرة...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.tealAccent),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: InspirationManager.getAllStories(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator(color: Colors.tealAccent));
                
                var stories = (snapshot.data as List).where((s) => 
                  s['title'].toString().contains(searchQuery) || 
                  s['content'].toString().contains(searchQuery)
                ).toList();

                return ListView.builder(
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    var story = stories[index];
                    return Card(
                      color: Colors.white.withOpacity(0.05),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        title: Text(story['title'], style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold)),
                        subtitle: Text(story['category'], style: TextStyle(color: Colors.white70)),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 15),
                        onTap: () {
                          // فتح تفاصيل القصة (المرحلة الجاية)
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
