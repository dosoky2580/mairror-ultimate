import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedVoice = 'سيف (افتراضي)';
  bool _isUserVoiceActivated = false;

  final List<String> _voices = ['سيف', 'سارة', 'سلمى', 'سما', 'صوتي الشخصي'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('إعدادات ميرور الملكية')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionTitle('إعدادات صوت الترجمة والإلهام'),
          Card(
            color: const Color(0xFF1D1E33),
            child: Column(
              children: _voices.map((voice) => RadioListTile<String>(
                title: Text(voice, style: const TextStyle(color: Colors.white)),
                value: voice,
                groupValue: _selectedVoice,
                onChanged: (value) {
                  setState(() => _selectedVoice = value!);
                  // هنا يتم تخزين الصوت المختار ليعمل في كل الأركان
                },
                activeColor: Colors.amber,
              )).toList(),
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('بصمة الصوت (صوت تامر)'),
          ListTile(
            tileColor: const Color(0xFF1D1E33),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            leading: const Icon(Icons.mic_external_on, color: Colors.red),
            title: const Text('تسجيل بصمة صوتي', style: TextStyle(color: Colors.white)),
            subtitle: const Text('لتفعيل الصوت الخامس في كل الأركان', style: TextStyle(color: Colors.grey)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey),
            onTap: () {
               // هنا منطق تسجيل وتحليل صوت المستخدم
            },
          ),
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
