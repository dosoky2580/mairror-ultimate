import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lib/providers/app_provider.dart';
void main() => runApp(ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MaterialApp(home: Scaffold(body: Center(child: Text("تم بنجاح يا تامر")))),
    ));
