import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MairrorApp());
}

class MairrorApp extends StatelessWidget {
  const MairrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mairror Ultimate',
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      home: const MainWorldsScreen(), // الدخول مباشرة للواجهة
    );
  }
}

class MainWorldsScreen extends StatelessWidget {
  const MainWorldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Mairror Ultimate"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        children: [
          _buildWorldCard(context, "عالم العدسة", Icons.camera_alt, Colors.red),
          _buildWorldCard(context, "عالم المترجم", Icons.translate, Colors.blue),
          _buildWorldCard(context, "عالم المستندات", Icons.description, Colors.green),
          _buildWorldCard(context, "ساحة الألعاب", Icons.sports_esports, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildWorldCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      color: Colors.grey[900],
      child: InkWell(
        onTap: () {
          // هنا يتم تحميل المكتبات الخاصة بكل عالم عند الضغط عليه فقط
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
