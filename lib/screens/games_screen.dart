import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('ساحة ألعاب ميرور الذكية')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('تحدى ميرور في الشطرنج (Logic 0.8.1)', 
                style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // رقعة الشطرنج الاحترافية
            Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.brown,
                boardOrientation: PlayerColor.white,
                onMove: () {
                  // هنا يتم استدعاء محرك الذكاء الاصطناعي للرد على الحركة
                },
              ),
            ),
            const SizedBox(height: 30),
            _buildGameInfo(),
            const SizedBox(height: 20),
            // ركن مكعب روبيك (قيد التجهيز)
            _buildRubikTeaser(),
          ],
        ),
      ),
    );
  }

  Widget _buildGameInfo() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('اللاعب: تامر/سيف', style: TextStyle(color: Colors.white)),
          ElevatedButton(
            onPressed: () => controller.resetBoard(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('إعادة اللعب'),
          ),
        ],
      ),
    );
  }

  Widget _buildRubikTeaser() {
    return ListTile(
      leading: const Icon(Icons.view_in_ar, color: Colors.orange, size: 40),
      title: const Text('مكعب روبيك 3D', style: TextStyle(color: Colors.white)),
      subtitle: const Text('جاري ضبط محرك الحلول الذكي...', style: TextStyle(color: Colors.grey)),
      trailing: const Icon(Icons.lock_clock, color: Colors.grey),
    );
  }
}
