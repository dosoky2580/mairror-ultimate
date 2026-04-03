mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
import 'package:flutter/material.dart';
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
import 'package:provider/provider.dart';
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
import 'providers/app_provider.dart';
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g

mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
void main() {
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  runApp(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    ChangeNotifierProvider(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      create: (_) => AppProvider(),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      child: const MairrorApp(),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    ),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  );
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
}
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g

mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
class MairrorApp extends StatelessWidget {
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  const MairrorApp({super.key});
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g

mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  @override
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  Widget build(BuildContext context) {
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    final provider = Provider.of<AppProvider>(context);
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    return MaterialApp(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      title: 'Mairror Ultimate',
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      debugShowCheckedModeBanner: false,
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      themeMode: provider.themeMode,
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: Brightness.dark),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      ),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      theme: ThemeData.light(useMaterial3: true).copyWith(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      ),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      home: const MainNavigationScreen(),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    );
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  }
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
}
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g

mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
class MainNavigationScreen extends StatefulWidget {
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  const MainNavigationScreen({super.key});
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g

mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  @override
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
}
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g

mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
class _MainNavigationScreenState extends State<MainNavigationScreen> {
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  int _selectedIndex = 0;
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  final List<Widget> _screens = [
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    const HomeScreen(),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    const Center(child: Text('📷 عدسة المرايا الذكية', style: TextStyle(fontSize: 22))),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    const Center(child: Text('♟️ ركن الألعاب (3D)', style: TextStyle(fontSize: 22))),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    const Center(child: Text('📖 قصص القرآن الكريم', style: TextStyle(fontSize: 22))),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    const Center(child: Text('⚙️ إعدادات أدهم', style: TextStyle(fontSize: 22))),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  ];
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g

mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  @override
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  Widget build(BuildContext context) {
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    return Scaffold(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      app_bar: AppBar(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        title: const Text('Mairror Ultimate 💎'),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        actions: [
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
          IconButton(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
            icon: const Icon(Icons.brightness_6),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
            onPressed: () => context.read<AppProvider>().toggleTheme(),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
          )
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        ],
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      ),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      body: _screens[_selectedIndex],
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      bottomNavigationBar: NavigationBar(
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        selectedIndex: _selectedIndex,
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        destinations: const [
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
          NavigationDestination(icon: Icon(Icons.translate), label: 'ترجمة'),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
          NavigationDestination(icon: Icon(Icons.camera_alt), label: 'عدسة'),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
          NavigationDestination(icon: Icon(Icons.games), label: 'ألعاب'),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
          NavigationDestination(icon: Icon(Icons.auto_stories), label: 'قصص'),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
          NavigationDestination(icon: Icon(Icons.settings), label: 'إعدادات'),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
        ],
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
      ),
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
    );
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
  }
mport 'providers/app_provider.dart';/import 'providers/app_provider.dart';
import 'screens/home_screen.dart';/g
}
