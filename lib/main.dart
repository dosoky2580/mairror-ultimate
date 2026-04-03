import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mairror_ultimate/providers/app_provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final TextEditingController _controller = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text("Mirror Pro - أدهم")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: "اكتب ما يمليه عليك قلبك..."),
              ),
              const SizedBox(height: 20),
              if (provider.isWorking) const CircularProgressIndicator(),
              Text(provider.resultText, style: const TextStyle(fontSize: 18)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => provider.processText(_controller.text),
                    child: const Text("ترجم وانطق"),
                  ),
                  IconButton(
                    icon: Icon(provider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    onPressed: () => provider.toggleTheme(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
