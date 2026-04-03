import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MairrorApp(),
    ),
  );
}

class MairrorApp extends StatelessWidget {
  const MairrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      title: 'Mairror Ultimate',
      debugShowCheckedModeBanner: false,
      themeMode: provider.themeMode,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: Brightness.dark),
      ),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const Center(child: Text('🏠 شاشة الترجمة والإلهام', style: TextStyle(fontSize: 22))),
    const Center(child: Text('📷 عدسة المرايا الذكية', style: TextStyle(fontSize: 22))),
    const Center(child: Text('♟️ ركن الألعاب (3D)', style: TextStyle(fontSize: 22))),
    const Center(child: Text('📖 قصص القرآن الكريم', style: TextStyle(fontSize: 22))),
    const Center(child: Text('⚙️ إعدادات أدهم', style: TextStyle(fontSize: 22))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      app_bar: AppBar(
        title: const Text('Mairror Ultimate 💎'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<AppProvider>().toggleTheme(),
          )
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.translate), label: 'ترجمة'),
          NavigationDestination(icon: Icon(Icons.camera_alt), label: 'عدسة'),
          NavigationDestination(icon: Icon(Icons.games), label: 'ألعاب'),
          NavigationDestination(icon: Icon(Icons.auto_stories), label: 'قصص'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'إعدادات'),
        ],
      ),
    );
  }
}
