import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _urlController = TextEditingController();

  void _shareContent() {
    Share.share('أشارك معك هذا المستند المترجم بدقة عبر 🛡️ Mairror Ultimate');
  }

  Future<void> _openUrl() async {
    final Uri url = Uri.parse('https://google.com');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مكتبة ميرور")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: _openUrl, child: Text("فتح الرابط")),
            ElevatedButton(onPressed: _shareContent, child: Text("مشاركة")),
          ],
        ),
      ),
    );
  }
}
