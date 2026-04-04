import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('ساحة الألعاب الذكية')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('شطرنج ميرور (Logic 0.8.1)', 
                style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // رقعة الشطرنج الرسمية والمستقرة
            ChessBoard(
              onMove: () {},
              onCheckMate: (color) {},
              onDraw: () {},
              size: MediaQuery.of(context).size.width * 0.9,
              enableUserMoves: true,
            ),
            const SizedBox(height: 30),
            const Text('تحدى الذكاء الاصطناعي بصوت أدهم', 
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
