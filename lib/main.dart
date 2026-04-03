import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mairror_ultimate/providers/app_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        body: Center( // هنا التصحيح يا تامر: body وليس app_view
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(provider.translatedText, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => provider.toggleTheme(),
                child: const Text("تغيير الوضع"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
