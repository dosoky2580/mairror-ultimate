import 'package:mairror_ultimate/worlds/docs_world.dart';
import 'package:mairror_ultimate/worlds/lens_world.dart';
import 'package:flutter/material.dart';
import 'package:mairror_ultimate/worlds/translator_world.dart'; // تأكد من اسم الباكيج صح

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
      theme: ThemeData(brightness: Brightness.dark),
      home: const MainWorldsScreen(),
    );
  }
}

class MainWorldsScreen extends StatelessWidget {
  const MainWorldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Mairror Ultimate"), centerTitle: true),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _buildWorldCard(context, "عالم العدسة", Icons.camera_alt, Colors.redAccent, const LensWorld()),
          _buildWorldCard(context, "عالم المترجم", Icons.translate, Colors.blueAccent, const TranslatorWorld()),
          _buildWorldCard(context, "عالم المستندات", Icons.description, Colors.greenAccent, const DocsWorld()),
          _buildWorldCard(context, "ساحة الألعاب", Icons.sports_esports, Colors.purpleAccent, null),
        ],
      ),
    );
  }

  Widget _buildWorldCard(BuildContext context, String title, IconData icon, Color color, Widget? destination) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          if (destination != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
