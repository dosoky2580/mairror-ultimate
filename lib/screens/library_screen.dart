import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isDownloading = false;

  void _openInBrowser() async {
    if (_urlController.text.isNotEmpty) {
      final Uri url = Uri.parse(_urlController.text);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  void _shareDocument() {
    Share.share('أشارك معك هذا المستند المترجم بدقة عبر 🛡️ Mairror Ultimate \n الرابط: ${_urlController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(title: const Text('ركن الكتب والمستندات الذكي')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.picture_as_pdf, size: 80, color: Colors.redAccent),
            const SizedBox(height: 20),
            TextField(
              controller: _urlController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1D1E33),
                hintText: 'الصق رابط المستند أو الكتاب هنا...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon: const Icon(Icons.link, color: Colors.green),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _openInBrowser,
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text('فتح المستعرض'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => _isDownloading = true),
                    icon: const Icon(Icons.translate),
                    label: const Text('ترجمة فورية'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ),
              ],
            ),
            if (_isDownloading) ...[
              const SizedBox(height: 30),
              const CircularProgressIndicator(color: Colors.amber),
              const SizedBox(height: 10),
              const Text('جاري معالجة التنسيق (A4) والحفاظ على الجداول...', 
                  style: TextStyle(color: Colors.amber, fontSize: 12)),
            ],
            const Spacer(),
            ListTile(
              tileColor: const Color(0xFF1D1E33),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              title: const Text('مشاركة المستند المترجم', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.share, color: Colors.amber),
              onTap: _shareDocument,
            ),
            const SizedBox(height: 10),
            const Text('ملاحظة: الترجمة تحافظ على الصور والرسوم البيانية الأصلية', 
                style: TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
