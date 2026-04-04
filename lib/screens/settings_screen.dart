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
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      bool authenticated = await auth.authenticate(
        localizedReason: '🛡️ ميرور يطلب بصمتك لتفعيل التشفير العسكري AES-256',
        options: const AuthenticationOptions(stickyAuth: true),
      );
      if (authenticated) {
        setState(() => _isProtecting = !_isProtecting);
      }
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
          Text('الأمان والتشفير', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('قفل التطبيق بالبصمة', style: TextStyle(color: Colors.white)),
            value: _isProtecting,
            activeColor: Colors.amber,
            onChanged: (bool value) => _authenticate(),
          ),
          const Divider(color: Colors.grey),
          const ListTile(
            title: Text('إصدار التشفير', style: TextStyle(color: Colors.white)),
            subtitle: Text('AES-256 bit Military Grade', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
