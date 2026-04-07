import 'package:flutter/material.dart';

void main() {
  // تشغيل التطبيق فوراً بدون انتظار المكتبات
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MairrorApp());
}

class MairrorApp extends StatelessWidget {
  const MairrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mairror Ultimate',
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      // الدخول لصفحة خفيفة أولاً
      home: const FastSplashScreen(),
    );
  }
}

class FastSplashScreen extends StatefulWidget {
  const FastSplashScreen({super.key});

  @override
  State<FastSplashScreen> createState() => _FastSplashScreenState();
}

class _FastSplashScreenState extends State<FastSplashScreen> {
  @override
  void initState() {
    super.initState();
    // تحميل المكتبات الثقيلة في الخلفية بعد ظهور الشاشة
    _loadEngines();
  }

  Future<void> _loadEngines() async {
    await Future.delayed(const Duration(seconds: 2));
    // هنا ممكن تضيف محركاتك تدريجياً
    if (mounted) {
       // الانتقال للواجهة الرئيسية بعد التحميل
       // Navigator.of(context).pushReplacement(...)
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mairror Ultimate", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 10),
            Text("جاري تحضير العوالم...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
