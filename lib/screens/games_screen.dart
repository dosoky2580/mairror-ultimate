import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ركن الألعاب')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          _gameCard(context, 'الشطرنج 3D', Icons.grid_on, Colors.brown, () {}),
          _gameCard(context, 'مكعب روبيك', Icons.view_in_ar, Colors.orange, () {}),
        ],
      ),
    );
  }

  Widget _gameCard(context, title, icon, color, action) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: action,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: color),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
