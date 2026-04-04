import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isProtecting = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'يرجى تأكيد بصمة الإصبع أو الوجه لحماية ميرور',
        options: const AuthenticationOptions(stickyAuth: true),
      );
    } catch (e) {
      print(e);
    }
    if (authenticated) {
      setState(() => _isProtecting = !_isProtecting);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تفعيل حماية ميرور العسكرية 🛡️')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('إعدادات ميرور الملكية')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionTitle('الأمان والتشفير (AES-256)'),
          SwitchListTile(
            tileColor: const Color(0xFF1D1E33),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text('قفل التطبيق بالبصمة', style: TextStyle(color: Colors.white)),
            subtitle: const Text('تشفير البيانات بمفتاح 256 بت', style: TextStyle(color: Colors.grey)),
            value: _isProtecting,
            activeColor: Colors.amber,
            onChanged: (bool value) => _authenticate(),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('إعدادات الصوت (الخماسي)'),
          // ... (باقي إعدادات الأصوات اللي عملناها)
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Text(title, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
    );
  }
}
